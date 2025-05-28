import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_event.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_state.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
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

  const MatchDetailsPage({Key? key, required this.fixture}) : super(key: key);

  @override
  _MatchDetailsPageState createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoadingTabData = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);

    // Add listener to load data for specific tabs as they are selected
    _tabController.addListener(_handleTabChange);
  }

  // Store this to access bloc safely
  BuildContext? _providerContext;

  void _handleTabChange() {
    // Only trigger when the tab actually changes
    if (!_tabController.indexIsChanging) {
      return;
    }

    // Pre-fetch data for specific tabs based on the selected index
    // This improves user experience by loading data in advance
    final fixtureId = widget.fixture.fixture.id;
    final leagueId = widget.fixture.league.id;
    final season = widget.fixture.league.season;

    // Show a loading indicator for smoother transitions between tabs
    setState(() {
      _isLoadingTabData = true;
    });

    // Use Future.delayed to give time for the tab transition animation
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return;

      try {
        // Refresh data depending on which tab we're viewing
        if (_tabController.index >= 2 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<FixtureDetailsBloc>(_providerContext!);
            bloc.add(RefreshFixtureDetails(fixtureId));
          } catch (e) {
            print('Error accessing FixtureDetailsBloc: $e');
          }
        }

        // Load standings data when on the table tab
        if (_tabController.index == 5 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<StandingsBloc>(_providerContext!);
            bloc.add(FetchStandingsEvent(
              leagueId: leagueId,
              season: season,
            ));
          } catch (e) {
            print('Error accessing StandingsBloc: $e');
          }
        }

        // Specifically load prediction data when on that tab
        if (_tabController.index == 6 && _providerContext != null) {
          try {
            final bloc = BlocProvider.of<PredictionBloc>(_providerContext!);
            bloc.add(FetchMatchPredictionEvent(matchId: fixtureId));
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<FixtureDetailsBloc>()
            ..add(LoadFixtureDetails(widget.fixture.fixture.id)),
        ),
        BlocProvider(
          create: (_) => getIt<PredictionBloc>()
            ..add(
                FetchMatchPredictionEvent(matchId: widget.fixture.fixture.id)),
        ),
        BlocProvider(
          create: (_) => getIt<StandingsBloc>(),
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

                  // Use loaded fixture if available, otherwise fall back to the widget fixture
                  final fixtureToUse =
                      (state is FixtureDetailsLoaded && state.hasFixtures)
                          ? state.fixture!
                          : widget.fixture;

                  // Create widgets for each tab to avoid the "method not defined" compiler error
                  final summaryWidget = SummaryTab(
                      key: ValueKey('summary'), fixture: fixtureToUse);
                  final eventsWidget =
                      EventsTab(key: ValueKey('events'), fixture: fixtureToUse);
                  final lineupWidget =
                      LineupTab(key: ValueKey('lineup'), fixture: fixtureToUse);
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
                          color: Colors.black.withOpacity(0.1),
                          child: Center(
                            child: CircularProgressIndicator(),
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
