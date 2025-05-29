import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_converter.dart';
import 'package:football_live_app/presentation/pages/match_details/utils/fixture_data_provider.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/events_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/h2h_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/lineup_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/match_score_header.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/predictions_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/stats_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/summary_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/table_tab.dart';
import 'package:football_live_app/presentation/utils/app_theme.dart';
import 'package:football_live_app/presentation/utils/responsive_helper.dart';
import 'package:football_live_app/presentation/widgets/error_widget.dart';
import 'package:football_live_app/presentation/widgets/loading_widget.dart';

class MatchDetailsPage extends StatefulWidget {
  final FixtureData fixture;
  // Flag to indicate whether to fetch full details from API
  final bool fetchFullDetails;

  const MatchDetailsPage({
    Key? key,
    required this.fixture,
    this.fetchFullDetails = false,
  }) : super(key: key);

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoadingTabData = false;

  // Track if we've loaded detailed fixture data
  bool _initialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);

    // Add listener to load data for specific tabs as they are selected
    _tabController.addListener(_handleTabChange);
  }

  /// Extract and log detailed fixture information
  void _logDetailedFixtureInfo(FixtureData fixture) {
    print('\n===== DETAILED FIXTURE INFO =====');
    print('Match ID: ${fixture.fixture.id}');
    print('Match: ${fixture.teams.home.name} vs ${fixture.teams.away.name}');
    print('Score: ${fixture.goals.home ?? 0} - ${fixture.goals.away ?? 0}');
    print('Status: ${fixture.fixture.status.long}');

    // Extract events (goals, cards, subs)
    final events = fixture.getEvents();
    print('\nEvents: ${events.length}');
    if (events.isNotEmpty) {
      print(
          'First event: ${events.first.type} at ${events.first.time.elapsed}\'');

      // Count goals
      final goals = events.where((e) => e.type.toLowerCase() == 'goal').length;
      print('Goals: $goals');

      // Count cards
      final cards = events.where((e) => e.type.toLowerCase() == 'card').length;
      print('Cards: $cards');
    }

    // Extract lineups
    final lineups = fixture.getLineups();
    print('\nLineups: ${lineups.length}');
    if (lineups.isNotEmpty) {
      print(
          'Home formation: ${lineups.firstWhere((l) => l.team.id == fixture.teams.home.id, orElse: () => LineupData(team: fixture.teams.home, coach: Coach(id: 0, name: "Unknown"), formation: "Unknown", startXI: [], substitutes: [])).formation}');
      print(
          'Away formation: ${lineups.firstWhere((l) => l.team.id == fixture.teams.away.id, orElse: () => LineupData(team: fixture.teams.away, coach: Coach(id: 0, name: "Unknown"), formation: "Unknown", startXI: [], substitutes: [])).formation}');
    }

    // Extract statistics
    final statistics = fixture.getStatistics();
    print('\nStatistics available: ${statistics != null}');
    if (statistics != null) {
      // Check home and away stats
      final homeStats = statistics.home;
      final awayStats = statistics.away;

      print('Home stats: ${homeStats?.length ?? 0} categories');
      print('Away stats: ${awayStats?.length ?? 0} categories');

      // Try to find possession stats for home team
      if (homeStats != null && homeStats.isNotEmpty) {
        final possessionStat = homeStats.firstWhere(
          (stat) => stat.type.toLowerCase().contains('possession'),
          orElse: () => TeamStatistics(type: 'Not found', value: '0'),
        );

        print(
            '${fixture.teams.home.name} possession: ${possessionStat.value ?? 'N/A'}');
      }

      // Try to find possession stats for away team
      if (awayStats != null && awayStats.isNotEmpty) {
        final possessionStat = awayStats.firstWhere(
          (stat) => stat.type.toLowerCase().contains('possession'),
          orElse: () => TeamStatistics(type: 'Not found', value: '0'),
        );

        print(
            '${fixture.teams.away.name} possession: ${possessionStat.value ?? 'N/A'}');
      }
    }

    print('===== END DETAILED INFO =====\n');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // This is a good place to load the initial data once
    // after the context is available but before the build completes
    if (!_initialDataLoaded) {
      _initialDataLoaded = true;

      // Log the initial fixture data received from navigation
      print('Match details opened with fixture data:');
      print('Match ID: ${widget.fixture.fixture.id}');
      print(
          'Match: ${widget.fixture.teams.home.name} vs ${widget.fixture.teams.away.name}');
      print('Status: ${widget.fixture.fixture.status.long}');
      print('League: ${widget.fixture.league.name}');
      print('Fetch full details flag: ${widget.fetchFullDetails}');

      // If fetchFullDetails is true, we should prefetch all the required data for tabs
      if (widget.fetchFullDetails) {
        _preloadAllTabsData();
      } else {
        // Log detailed fixture info for debugging
        _logDetailedFixtureInfo(widget.fixture);
      }
    }
  }

  /// Preload all the necessary data for all tabs at once to provide a complete experience
  void _preloadAllTabsData() {
    // Don't proceed if context is not ready yet
    if (!mounted) return;

    final fixtureId = widget.fixture.fixture.id;
    final leagueId = widget.fixture.league.id;
    final season = widget.fixture.league.season;

    try {
      // Set loading state
      setState(() {
        _isLoadingTabData = true;
      });

      // We need to make sure that the blocs are initialized before we can call read()
      // So we use Future.microtask to ensure all dependencies are ready
      Future.microtask(() {
        if (!mounted) return;

        // Make a single API call to get fixture details by ID
        // This single request returns comprehensive data for multiple tabs:
        // - Events (goals, cards, subs)
        // - Lineups (formations, players)
        // - Statistics (possession, shots, etc.)
        // - Player data
        try {
          // Using the fixtures endpoint with ID parameter
          context.read<FixtureDetailsBloc>().add(LoadFixtureDetails(fixtureId));
          print('Fetching complete fixture details for ID: $fixtureId');
        } catch (e) {
          print('Error loading fixture details: $e');
        }

        // Standings data requires a separate API call with league ID and season
        try {
          context.read<StandingsBloc>().add(
                FetchStandingsEvent(
                  leagueId: leagueId,
                  season: season,
                ),
              );
          print('Fetching standings for league ID: $leagueId, season: $season');
        } catch (e) {
          print('Error loading standings: $e');
        }

        // Predictions data also requires a separate API call with fixture ID
        try {
          context
              .read<PredictionBloc>()
              .add(FetchMatchPredictionEvent(matchId: fixtureId));
          print('Fetching predictions for fixture ID: $fixtureId');
        } catch (e) {
          print('Error loading predictions: $e');
        }

        // Clear loading state after all data has been loaded
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _isLoadingTabData = false;
              print('All tab data preloaded successfully');
            });
          }
        });
      });
    } catch (e) {
      print('Error in preloading tab data: $e');
      if (mounted) {
        setState(() {
          _isLoadingTabData = false;
        });
      }
    }
  }

  // Store this to access bloc safely
  BuildContext? _providerContext;

  /// Demonstrates extracting specific data from a fixture for different tabs
  void _demonstrateFixtureDataExtraction(
      BuildContext context, FixtureData fixture, int tabIndex) {
    print("\n===== TAB ${tabIndex} DATA EXTRACTION =====");
    switch (tabIndex) {
      case 0: // Summary tab
        print("SUMMARY TAB DATA:");
        print(
            "Match: ${fixture.teams.home.name} vs ${fixture.teams.away.name}");
        print("Score: ${fixture.goals.home ?? 0} - ${fixture.goals.away ?? 0}");
        print("Date: ${fixture.fixture.date}");
        break;

      case 1: // Events tab
        final events = FixtureDataProvider.getSortedEvents(fixture);
        print("EVENTS TAB DATA:");
        print("Total events: ${events.length}");

        if (events.isNotEmpty) {
          // Group events by type
          final goals =
              events.where((e) => e.type.toLowerCase() == 'goal').toList();
          final cards =
              events.where((e) => e.type.toLowerCase() == 'card').toList();
          final substitutions =
              events.where((e) => e.type.toLowerCase() == 'subst').toList();

          print("Goals: ${goals.length}");
          print("Cards: ${cards.length}");
          print("Substitutions: ${substitutions.length}");

          // Home vs Away events
          final homeEvents =
              events.where((e) => e.team.id == fixture.teams.home.id).length;
          final awayEvents =
              events.where((e) => e.team.id == fixture.teams.away.id).length;
          print("Home team events: $homeEvents");
          print("Away team events: $awayEvents");
        }
        break;

      case 2: // Lineups tab
        print("LINEUPS TAB DATA:");
        final lineups = fixture.getLineups();
        print("Lineup data available: ${lineups.isNotEmpty}");

        if (lineups.isNotEmpty) {
          // Extract home team lineup
          final homeLineup =
              FixtureDataProvider.getTeamLineup(fixture, fixture.teams.home.id);
          if (homeLineup != null) {
            print(
                "${fixture.teams.home.name} formation: ${homeLineup.formation}");
            print(
                "${fixture.teams.home.name} starting XI: ${homeLineup.startXI.length} players");
            print(
                "${fixture.teams.home.name} substitutes: ${homeLineup.substitutes.length} players");
            print("${fixture.teams.home.name} coach: ${homeLineup.coach.name}");
          }

          // Extract away team lineup
          final awayLineup =
              FixtureDataProvider.getTeamLineup(fixture, fixture.teams.away.id);
          if (awayLineup != null) {
            print(
                "${fixture.teams.away.name} formation: ${awayLineup.formation}");
            print(
                "${fixture.teams.away.name} starting XI: ${awayLineup.startXI.length} players");
            print(
                "${fixture.teams.away.name} substitutes: ${awayLineup.substitutes.length} players");
            print("${fixture.teams.away.name} coach: ${awayLineup.coach.name}");
          }
        }
        break;

      case 3: // Stats tab
        print("STATS TAB DATA:");
        final statistics = fixture.getStatistics();
        print("Statistics data available: ${statistics != null}");

        if (statistics != null) {
          // Print some key statistics for demonstration
          if (statistics.home != null && statistics.home!.isNotEmpty) {
            print(
                "${fixture.teams.home.name} stats categories: ${statistics.home!.length}");

            // Try to extract common statistics
            _printTeamStat(
                statistics.home!, "Ball Possession", fixture.teams.home.name);
            _printTeamStat(
                statistics.home!, "Total Shots", fixture.teams.home.name);
            _printTeamStat(
                statistics.home!, "Shots on Goal", fixture.teams.home.name);
          }

          if (statistics.away != null && statistics.away!.isNotEmpty) {
            print(
                "${fixture.teams.away.name} stats categories: ${statistics.away!.length}");

            // Try to extract common statistics
            _printTeamStat(
                statistics.away!, "Ball Possession", fixture.teams.away.name);
            _printTeamStat(
                statistics.away!, "Total Shots", fixture.teams.away.name);
            _printTeamStat(
                statistics.away!, "Shots on Goal", fixture.teams.away.name);
          }
        }
        break;

      default:
        print("Data extraction not implemented for tab $tabIndex");
        break;
    }
    print("===== END TAB DATA EXTRACTION =====\n");
  }

  /// Helper method to print a team statistic if it exists
  void _printTeamStat(
      List<TeamStatistics> stats, String statName, String teamName) {
    try {
      final stat = stats.firstWhere(
        (s) =>
            s.type == statName ||
            s.type.toLowerCase().contains(statName.toLowerCase()),
        orElse: () => TeamStatistics(type: 'Not found', value: null),
      );

      if (stat.type != 'Not found') {
        print("$teamName ${stat.type}: ${stat.value ?? 'N/A'}");
      }
    } catch (e) {
      print("Error finding $statName stat: $e");
    }
  }

  void _handleTabChange() {
    // Only trigger when the tab actually changes
    if (!_tabController.indexIsChanging) {
      return;
    }

    final fixtureId = widget.fixture.fixture.id;
    final leagueId = widget.fixture.league.id;
    final season = widget.fixture.league.season;
    final selectedTabIndex = _tabController.index;

    // Show a loading indicator for smoother transitions between tabs
    setState(() {
      _isLoadingTabData = true;
    });

    // Use Future.delayed to give time for the tab transition animation
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return;

      try {
        // For most tabs (0-4), we don't need to refresh fixture details data
        // since we already have comprehensive data from the initial load.
        // Only refresh if there's a specific reason (like real-time updates for live matches)

        final isLiveMatch = widget.fixture.fixture.status.short == '1H' ||
            widget.fixture.fixture.status.short == '2H' ||
            widget.fixture.fixture.status.short == 'HT';

        // For live matches, refresh fixture data more frequently
        if (isLiveMatch && selectedTabIndex <= 4 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<FixtureDetailsBloc>(_providerContext!);
            bloc.add(RefreshFixtureDetails(fixtureId));
          } catch (e) {
            print('Error accessing FixtureDetailsBloc: $e');
          }
        }

        // Only load standings data when the table tab is selected and it hasn't been loaded yet
        if (selectedTabIndex == 5 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<StandingsBloc>(_providerContext!);
            final currentState = bloc.state;

            // Only fetch if we don't have the data or if it's for a different league
            bool shouldLoadStandings = currentState is! StandingsLoaded;
            if (currentState is StandingsLoaded) {
              shouldLoadStandings = currentState.standings.isEmpty;
            }

            if (shouldLoadStandings) {
              bloc.add(FetchStandingsEvent(
                leagueId: leagueId,
                season: season,
              ));
            }
          } catch (e) {
            print('Error accessing StandingsBloc: $e');
          }
        }

        // Only load prediction data when the predictions tab is selected and it hasn't been loaded yet
        if (selectedTabIndex == 6) {
          try {
            if (_providerContext != null) {
              final bloc = BlocProvider.of<PredictionBloc>(_providerContext!);
              final currentState = bloc.state;

              // Only fetch if we don't have the data or if it's for a different match
              if (currentState is! PredictionLoaded) {
                bloc.add(FetchMatchPredictionEvent(matchId: fixtureId));
              }
            }
          } catch (e) {
            print('Error accessing PredictionBloc: $e');
          }
        }
      } catch (e) {
        print('Error in tab change handler: $e');
      }

      if (mounted) {
        // Extract and demonstrate fixture data for the selected tab
        final fixtureData =
            FixtureDataProvider.getBestFixtureData(context, widget.fixture);
        _demonstrateFixtureDataExtraction(
            context, fixtureData, selectedTabIndex);

        setState(() {
          _isLoadingTabData = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get fixture ID needed for initializing blocs
    final fixtureId = widget.fixture.fixture.id;

    return MultiBlocProvider(
      providers: [
        // FixtureDetailsBloc for match summary, events, lineups, stats, and H2H
        // This single API call retrieves comprehensive data for multiple tabs
        BlocProvider(
          create: (_) {
            final bloc = getIt<FixtureDetailsBloc>();
            // Only trigger the load if we don't already have data from navigation
            if (!widget.fetchFullDetails) {
              bloc.add(LoadFixtureDetails(fixtureId));
            }
            return bloc;
          },
        ),
        // PredictionBloc for predictions tab - lazy loaded when needed
        BlocProvider(
          create: (_) => getIt<PredictionBloc>(),
          // We don't immediately trigger the event here to avoid unnecessary API calls
          // It will be loaded when the tab is selected or during preload
        ),
        // StandingsBloc for table tab - lazy loaded when needed
        BlocProvider(
          create: (_) => getIt<StandingsBloc>(),
          // We don't immediately trigger the event here to avoid unnecessary API calls
          // It will be loaded when the tab is selected or during preload
        ),
      ],
      child: Builder(
        builder: (context) {
          // Save the provider context for use in tab changes
          _providerContext = context;

          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 300.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                          BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
                        builder: (context, state) {
                          if (state is FixtureDetailsLoaded &&
                              state.hasFixtures) {
                            // Use the getter that returns the first fixture
                            return MatchScoreHeader(fixture: state.fixture!);
                          }
                          return MatchScoreHeader(fixture: widget.fixture);
                        },
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveHelper.isMobile(context) ? 13 : 14,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: ResponsiveHelper.isMobile(context) ? 13 : 14,
                      ),
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.primaryColor,
                            width: 3.0,
                          ),
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: AppTheme.primaryColor,
                      unselectedLabelColor: Colors.grey[600],
                      labelPadding: EdgeInsets.symmetric(
                        horizontal:
                            ResponsiveHelper.isMobile(context) ? 12 : 16,
                        vertical: 12,
                      ),
                      tabs: [
                        Tab(text: 'Summary'),
                        Tab(text: 'Events'),
                        Tab(text: 'Lineups'),
                        Tab(text: 'Stats'),
                        Tab(text: 'H2H'),
                        Tab(text: 'Table'),
                        Tab(text: 'Predictions'),
                      ],
                    ),
                  ),
                ];
              },
              body: BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
                builder: (context, state) {
                  if (state is FixtureDetailsLoading) {
                    return LoadingWidget(
                      message: 'Loading match details...',
                    );
                  }

                  if (state is FixtureDetailsError) {
                    return ErrorDisplayWidget(
                      message: 'Error loading match details: ${state.message}',
                      onRetry: () {
                        context.read<FixtureDetailsBloc>().add(
                              RefreshFixtureDetails(widget.fixture.fixture.id),
                            );
                      },
                    );
                  }

                  // Use the FixtureDataProvider to get the best available fixture data
                  FixtureData fixtureToUse =
                      FixtureDataProvider.getBestFixtureData(
                          context, widget.fixture);

                  // Check if we have detailed data or need to show a hint
                  final hasDetailedData = fixtureToUse.hasDetailedData;
                  print('Fixture detailed data available: $hasDetailedData');

                  // If no detailed data is available and this is a first load,
                  // we'll show a hint after the build is complete
                  /* if (!hasDetailedData &&
                      !_isLoadingTabData &&
                      widget.fetchFullDetails) {
                    // Use a post-frame callback to safely show the SnackBar after build is complete
                    Future.microtask(() {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Select a tab to view detailed match information'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    });
                  } */

                  // Create widgets for each tab using the imported widgets
                  final summaryWidget = SummaryTab(
                      key: const ValueKey('summary'), fixture: fixtureToUse);
                  final eventsWidget = EventsTab(
                      key: const ValueKey('events'), fixture: fixtureToUse);
                  final lineupWidget = LineupTab(
                      key: const ValueKey('lineup'), fixture: fixtureToUse);
                  final statsWidget =
                      StatsTab(key: ValueKey('stats'), fixture: fixtureToUse);
                  final h2hWidget =
                      H2HTab(key: ValueKey('h2h'), fixture: fixtureToUse);
                  final tableWidget =
                      TableTab(key: ValueKey('table'), fixture: fixtureToUse);
                  final predictionsWidget = PredictionsTab(
                      key: ValueKey('predictions'),
                      fixtureId: fixtureToUse.fixture.id);

                  return Stack(
                    children: [
                      TabBarView(
                        controller: _tabController,
                        physics:
                            const BouncingScrollPhysics(), // Smoother scrolling between tabs
                        children: [
                          // Wrap tabs in AnimatedSwitcher for smoother transitions
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: summaryWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: eventsWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: lineupWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: statsWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: h2hWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: tableWidget,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: predictionsWidget,
                          ),
                        ],
                      ),

                      // Show loading indicator when transitioning between tabs
                      if (_isLoadingTabData)
                        Container(
                          color: Colors.black.withOpacity(0.2),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text(
                                  'Loading match data...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: Colors.black,
                                        offset: Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
