import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/match_details_page.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';
import 'package:football_live_app/presentation/widgets/loading_indicator.dart';
import 'package:football_live_app/presentation/widgets/match_card.dart';
import 'package:football_live_app/presentation/widgets/no_data_view.dart';
import 'package:intl/intl.dart';

class FixturesTab extends StatefulWidget {
  const FixturesTab({super.key});

  @override
  State<FixturesTab> createState() => _FixturesTabState();
}

class _FixturesTabState extends State<FixturesTab>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late DateTime _selectedDate;
  late List<DateTime> _dateTabs;
  final Map<DateTime, List<FixtureData>?> _cachedMatches = {};

  @override
  void initState() {
    super.initState();
    _initDates();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabChange);
    _fetchMatchesForSelectedDate();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _initDates() {
    final today = DateTime.now();
    // Create date tabs: [today-2, today-1, today, today+1, today+2]
    _dateTabs = List.generate(
        5, (index) => DateTime(today.year, today.month, today.day - 2 + index));
    _selectedDate = _dateTabs[2]; // Default to today (middle tab)
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging ||
        _tabController.index != _tabController.previousIndex) {
      setState(() {
        _selectedDate = _dateTabs[_tabController.index];
      });

      // Only update the UI and fetch new data if state is mounted
      if (mounted) {
        _fetchMatchesForSelectedDate();
      }
    }
  }

  void _fetchMatchesForSelectedDate() {
    try {
      // Check if we already have cached matches for this date
      final cachedMatches = _cachedMatches[_selectedDate];
      if (cachedMatches != null) {
        // If we have matches in cache, no need to fetch
        return;
      }

      // Fetch matches for the selected date
      context.read<LiveMatchesBloc>().add(
            FetchTodayMatchesEvent(
              date: _selectedDate,
            ),
          );
    } catch (e) {
      debugPrint('Error fetching matches for date: $e');
    }
  }

  void _navigateToMatchDetails(FixtureData match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsPage(fixture: match),
      ),
    );
  }

  void _storeMatchesInCache(DateTime date, List<FixtureData> matches) {
    _cachedMatches[date] = matches;
  }

  void _jumpToTodayTab() {
    // Animate to the center tab (today)
    _tabController.animateTo(2);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchMatchesForSelectedDate();
        return Future.delayed(const Duration(milliseconds: 1500));
      },
      child: Column(
        children: [
          // Top card with current date
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Fixtures',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (!_isToday(_selectedDate))
                          GestureDetector(
                            onTap: _jumpToTodayTab,
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy').format(_selectedDate),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isToday(_selectedDate) ? 'TODAY' : 'MATCHES',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date navigation tabs
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: _dateTabs.map((date) {
                final isToday = _isToday(date);
                return Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isToday
                            ? 'TODAY'
                            : DateFormat('EEE').format(date).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM').format(date),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Matches list
          Expanded(
            child: BlocBuilder<LiveMatchesBloc, LiveMatchesState>(
              builder: (context, state) {
                if (state is LiveMatchesLoading) {
                  return LoadingIndicator(
                      message:
                          'Loading matches for ${DateFormat('d MMM').format(_selectedDate)}...');
                } else if (state is LiveMatchesError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: _fetchMatchesForSelectedDate,
                  );
                } else if (state is LiveMatchesEmpty) {
                  return NoDataView(
                    message:
                        'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                    icon: Icons.sports_soccer,
                    onRefresh: _fetchMatchesForSelectedDate,
                  );
                } else if (state is LiveMatchesLoaded) {
                  // Store fetched matches in cache
                  _storeMatchesInCache(_selectedDate, state.matches);

                  // Fetch predictions for upcoming matches
                  final matchIds = state.matches
                      .where((match) =>
                          match.fixture.status.short ==
                          "NS") // Not Started matches
                      .map((match) => match.fixture.id)
                      .toList();

                  if (matchIds.isNotEmpty) {
                    // Fetch predictions for upcoming matches
                    context.read<PredictionBloc>().add(
                          FetchMultipleMatchPredictionsEvent(
                            matchIds: matchIds,
                          ),
                        );
                  }

                  // Group matches by league
                  final groupedMatches = <int, List<FixtureData>>{};
                  for (final match in state.matches) {
                    if (!groupedMatches.containsKey(match.league.id)) {
                      groupedMatches[match.league.id] = [];
                    }
                    groupedMatches[match.league.id]!.add(match);
                  }

                  // Sort matches within each league by match time
                  for (final leagueId in groupedMatches.keys) {
                    groupedMatches[leagueId]!.sort((a, b) {
                      return DateTime.parse(a.fixture.date)
                          .compareTo(DateTime.parse(b.fixture.date));
                    });
                  }

                  // Sort leagues by name for consistency
                  final sortedLeagueIds = groupedMatches.keys.toList()
                    ..sort((a, b) {
                      final leagueA = groupedMatches[a]!.first.league;
                      final leagueB = groupedMatches[b]!.first.league;
                      return leagueA.name.compareTo(leagueB.name);
                    });

                  if (groupedMatches.isEmpty) {
                    return NoDataView(
                      message:
                          'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                      icon: Icons.sports_soccer,
                      onRefresh: _fetchMatchesForSelectedDate,
                    );
                  }

                  return ListView.builder(
                    itemCount: sortedLeagueIds.length,
                    itemBuilder: (context, index) {
                      final leagueId = sortedLeagueIds[index];
                      final matches = groupedMatches[leagueId]!;
                      final league = matches.first.league;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(league.logo),
                                  backgroundColor: Colors.transparent,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        league.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        league.country,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...matches.map((match) => MatchCard(
                                match: match,
                                onTap: () => _navigateToMatchDetails(match),
                              )),
                          const Divider(height: 16, thickness: 1),
                        ],
                      );
                    },
                  );
                }
                return Container(); // Fallback
              },
            ),
          ),
        ],
      ),
    );
  }
}
