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

class LiveMatchesTab extends StatefulWidget {
  final bool showLiveOnly;

  const LiveMatchesTab({super.key, this.showLiveOnly = true});

  @override
  State<LiveMatchesTab> createState() => _LiveMatchesTabState();
}

class _LiveMatchesTabState extends State<LiveMatchesTab>
    with TickerProviderStateMixin {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
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
    if (widget.showLiveOnly) {
      // If showing live only, always fetch live matches regardless of date
      _fetchLiveMatches();
      return;
    }

    try {
      // Check if we already have cached matches for this date
      final cachedMatches = _cachedMatches[_selectedDate];
      if (cachedMatches != null) {
        // If we have matches in cache and not showing live-only, no need to fetch
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

  void _fetchLiveMatches() {
    try {
      context.read<LiveMatchesBloc>().add(FetchLiveMatchesEvent());
    } catch (e) {
      debugPrint('Error fetching live matches: $e');
    }
  }

  void _navigateToMatchDetails(FixtureData match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsPage(matchId: match.fixture.id),
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

  @override
  void didUpdateWidget(LiveMatchesTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If we switched between live and all matches view, update content
    if (oldWidget.showLiveOnly != widget.showLiveOnly) {
      // Clear any existing cached state when toggling modes
      _cachedMatches.clear();

      if (widget.showLiveOnly) {
        _fetchLiveMatches();
      } else {
        // Init the tab controller to show today (center position) when switching to all matches
        _tabController.animateTo(2);
        _fetchMatchesForSelectedDate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (widget.showLiveOnly) {
          _fetchLiveMatches();
        } else {
          _fetchMatchesForSelectedDate();
        }
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
                          widget.showLiveOnly ? 'Live Now' : 'Matches',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (!widget.showLiveOnly && !_isToday(_selectedDate))
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
                      widget.showLiveOnly
                          ? DateFormat('EEEE, d MMMM yyyy')
                              .format(DateTime.now())
                          : DateFormat('EEEE, d MMMM yyyy')
                              .format(_selectedDate),
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
                          color:
                              widget.showLiveOnly ? Colors.red : Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.showLiveOnly
                            ? 'LIVE'
                            : (_isToday(_selectedDate) ? 'TODAY' : 'MATCHES'),
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

          // Date navigation tabs - only show when not in live mode
          if (!widget.showLiveOnly)
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
                      message: widget.showLiveOnly
                          ? 'Loading live matches...'
                          : 'Loading matches for ${DateFormat('d MMM').format(_selectedDate)}...');
                } else if (state is LiveMatchesError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: widget.showLiveOnly
                        ? _fetchLiveMatches
                        : _fetchMatchesForSelectedDate,
                  );
                } else if (state is LiveMatchesEmpty) {
                  return NoDataView(
                    message: widget.showLiveOnly
                        ? 'No live matches at the moment'
                        : 'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                    icon: Icons.sports_soccer,
                    onRefresh: widget.showLiveOnly
                        ? _fetchLiveMatches
                        : _fetchMatchesForSelectedDate,
                  );
                } else if (state is LiveMatchesLoaded) {
                  // Store fetched matches in cache
                  if (!widget.showLiveOnly) {
                    _storeMatchesInCache(_selectedDate, state.matches);
                  }

                  // Fetch predictions for upcoming matches
                  final matchIds = state.matches
                      .where((match) =>
                          match.status.short == "NS") // Not Started matches
                      .map((match) => match.id)
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
                  final groupedMatches = <int, List<Match>>{};
                  for (final match in state.matches) {
                    if (!groupedMatches.containsKey(match.league.id)) {
                      groupedMatches[match.league.id] = [];
                    }
                    groupedMatches[match.league.id]!.add(match);
                  }

                  // Sort matches within each league by match time
                  for (final leagueId in groupedMatches.keys) {
                    groupedMatches[leagueId]!.sort((a, b) {
                      // Put live matches first, then sort by start time
                      final aIsLive = a.status.short == "1H" ||
                          a.status.short == "2H" ||
                          a.status.short == "HT";
                      final bIsLive = b.status.short == "1H" ||
                          b.status.short == "2H" ||
                          b.status.short == "HT";

                      if (aIsLive && !bIsLive) return -1;
                      if (!aIsLive && bIsLive) return 1;

                      return a.date.compareTo(b.date);
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
                      message: widget.showLiveOnly
                          ? 'No live matches at the moment'
                          : 'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                      icon: Icons.sports_soccer,
                      onRefresh: widget.showLiveOnly
                          ? _fetchLiveMatches
                          : _fetchMatchesForSelectedDate,
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    // Each league gets a section with header + matches
                    itemCount: sortedLeagueIds.length,
                    itemBuilder: (context, index) {
                      final leagueId = sortedLeagueIds[index];
                      final leagueMatches = groupedMatches[leagueId]!;
                      final leagueInfo = leagueMatches.first.league;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add spacing between league sections
                          if (index > 0) const SizedBox(height: 16),

                          // League header with match count
                          _buildLeagueHeader(leagueInfo, leagueMatches.length),

                          // Matches in this league
                          ...leagueMatches.map((match) {
                            // Create a match with prediction if available
                            if (match.status.short == "NS") {
                              // Get prediction from BLoC if match is upcoming
                              return BlocBuilder<PredictionBloc,
                                  PredictionState>(
                                builder: (context, state) {
                                  // Only process if predictions are loaded
                                  if (state is MultiPredictionLoaded) {
                                    // Get prediction for this match
                                    final prediction =
                                        state.getPredictionForMatch(match.id);
                                    if (prediction != null) {
                                      // Create a new match with the prediction
                                      final matchWithPrediction = Match(
                                        id: match.id,
                                        referee: match.referee,
                                        timezone: match.timezone,
                                        date: match.date,
                                        timestamp: match.timestamp,
                                        venue: match.venue,
                                        status: match.status,
                                        league: match.league,
                                        homeTeam: match.homeTeam,
                                        awayTeam: match.awayTeam,
                                        score: match.score,
                                        events: match.events,
                                        prediction: prediction,
                                      );
                                      return MatchCard(
                                        match: matchWithPrediction,
                                        onTap: () => _navigateToMatchDetails(
                                            matchWithPrediction),
                                      );
                                    }
                                  }

                                  // Return original match if no prediction available
                                  return MatchCard(
                                    match: match,
                                    onTap: () => _navigateToMatchDetails(match),
                                  );
                                },
                              );
                            } else {
                              // For non-upcoming matches, just show the match card
                              return MatchCard(
                                match: match,
                                onTap: () => _navigateToMatchDetails(match),
                              );
                            }
                          }),
                        ],
                      );
                    },
                  );
                }

                // Initial state
                return LoadingIndicator(
                    message: widget.showLiveOnly
                        ? 'Fetching live matches...'
                        : 'Fetching matches for ${DateFormat('d MMM').format(_selectedDate)}...');
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget _buildLeagueHeader(League league, int matchCount) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // League logo
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: league.logo != null
                  ? Image.network(
                      league.logo!,
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.sports_soccer, size: 22),
                    )
                  : const Icon(Icons.sports_soccer, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          // League name and country
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  league.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (league.country != null)
                  Row(
                    children: [
                      if (league.round != null)
                        Text(
                          league.round!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      if (league.round != null && league.country != null)
                        Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      Text(
                        league.country!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Flag and match count
          Row(
            children: [
              // Match count badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$matchCount',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Flag
              if (league.flag != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    league.flag!,
                    width: 24,
                    height: 16,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
