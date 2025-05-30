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
import 'package:football_live_app/presentation/pages/match_details/widgets/lineup_tab_enhanced.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/match_score_header.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/predictions_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/stats_tab_enhanced.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/summary_tab.dart';
import 'package:football_live_app/presentation/pages/match_details/widgets/table_tab.dart';
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
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isLoadingTabData = false;

  // Track if we've loaded detailed fixture data
  bool _initialDataLoaded = false;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Add listener to load data for specific tabs as they are selected
    _tabController.addListener(_handleTabChange);

    // Add scroll listener for parallax effects
    _scrollController.addListener(_onScroll);

    // Start fade animation
    _fadeController.forward();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    }
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

      // Use SchedulerBinding.addPostFrameCallback to ensure this runs after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        // Make a single API call to get fixture details by ID
        // This single request returns comprehensive data for multiple tabs:
        // - Events (goals, cards, subs)
        // - Lineups (formations, players)
        // - Statistics (possession, shots, etc.)
        // - Player data
        try {
          // Show loading indicator for better UX
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Loading match details...'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Use FixtureDataProvider to request fixture refresh
          // This ensures we follow the app's rate limiting policy
          FixtureDataProvider.requestFixtureRefresh(context, fixtureId);
          print(
              'Fetching complete fixture details for ID: $fixtureId using FixtureDataProvider');
        } catch (e) {
          print('Error loading fixture details: $e');
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error loading match details: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
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
            // Use FixtureDataProvider to request refresh with rate limiting
            FixtureDataProvider.requestFixtureRefresh(
                _providerContext!, fixtureId);
            print(
                'Refreshing live match data for tab $selectedTabIndex with FixtureDataProvider');
          } catch (e) {
            print('Error refreshing fixture data: $e');
          }
        }

        // Only load H2H data when the H2H tab is selected
        if (selectedTabIndex == 4 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<FixtureDetailsBloc>(_providerContext!);
            final currentState = bloc.state;

            // Check if we already have H2H data for these teams
            bool shouldLoadH2H = true;
            if (currentState is FixtureDetailsLoaded) {
              shouldLoadH2H = !currentState.hasHeadToHeadFixtures;
            }

            if (shouldLoadH2H) {
              bloc.add(LoadHeadToHeadFixtures(
                team1Id: widget.fixture.teams.home.id,
                team2Id: widget.fixture.teams.away.id,
                limit: 10, // Load last 10 H2H matches
              ));
              print('Loading H2H data for teams: ${widget.fixture.teams.home.name} vs ${widget.fixture.teams.away.name}');
            }
          } catch (e) {
            print('Error accessing FixtureDetailsBloc for H2H: $e');
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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fadeController.dispose();
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
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                // Calculate responsive height based on screen size
                final screenHeight = MediaQuery.of(context).size.height;
                final expandedHeight = ResponsiveHelper.isMobile(context)
                    ? 280.0
                    : screenHeight > 800
                        ? 320.0
                        : 300.0;

                // Calculate parallax offset
                final parallaxOffset = _scrollOffset * 0.5;

                // Calculate opacity based on scroll position
                final opacity =
                    (1 - (_scrollOffset / expandedHeight)).clamp(0.0, 1.0);

                return [
                  SliverAppBar(
                    expandedHeight: expandedHeight,
                    floating: true,
                    snap: true,
                    pinned: false,
                    elevation: innerBoxIsScrolled ? 8.0 : 4.0,
                    backgroundColor: Colors.transparent,
                    leading: AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: false,
                      title: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.9 * opacity),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7 * opacity),
                              ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                      background: Transform.translate(
                        offset: Offset(0, -parallaxOffset),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.8),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.6),
                              ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                          child: AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _fadeAnimation,
                                child: BlocBuilder<FixtureDetailsBloc,
                                    FixtureDetailsState>(
                                  builder: (context, state) {
                                    if (state is FixtureDetailsLoaded &&
                                        state.hasFixtures) {
                                      // Use the getter that returns the first fixture
                                      return MatchScoreHeader(
                                          fixture: state.fixture!);
                                    }
                                    return MatchScoreHeader(
                                        fixture: widget.fixture);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(60.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black
                                  .withOpacity(innerBoxIsScrolled ? 0.2 : 0.1),
                            ],
                          ),
                          boxShadow: innerBoxIsScrolled
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return FadeTransition(
                              opacity: _fadeAnimation,
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                physics: const BouncingScrollPhysics(),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveHelper.isMobile(context)
                                      ? 13
                                      : 14,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                unselectedLabelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: ResponsiveHelper.isMobile(context)
                                      ? 13
                                      : 14,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 1.0,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                indicator: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(2.0),
                                  ),
                                ),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Colors.white,
                                unselectedLabelColor:
                                    Colors.white.withOpacity(0.7),
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveHelper.isMobile(context)
                                      ? 12
                                      : 16,
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
                            );
                          },
                        ),
                      ),
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
                        // Use FixtureDataProvider for consistent error handling and rate limiting
                        FixtureDataProvider.requestFixtureRefresh(
                            context, widget.fixture.fixture.id);
                      },
                    );
                  }

                  // Use FixtureDataProvider to get the best available fixture data
                  // This ensures we consistently access the most complete data across all tabs
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
                  // Use enhanced lineup tab for better data handling
                  final lineupWidget = LineupTabEnhanced(
                      key: const ValueKey('lineup'), fixture: fixtureToUse);
                  // Use enhanced stats tab for better UI and data presentation
                  final statsWidget = StatsTabEnhanced(
                      key: ValueKey('stats'), fixture: fixtureToUse);
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
