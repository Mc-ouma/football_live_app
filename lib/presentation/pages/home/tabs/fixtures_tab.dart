import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/match_details_page.dart';
import 'package:football_live_app/presentation/widgets/match_card.dart';
import 'package:intl/intl.dart';

class FixturesTab extends StatefulWidget {
  const FixturesTab({super.key});

  @override
  State<FixturesTab> createState() => _FixturesTabState();
}

class _FixturesTabState extends State<FixturesTab>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late DateTime _selectedDate;
  late List<DateTime> _dateTabs;
  final Map<DateTime, List<FixtureData>?> _cachedMatches = {};
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _initDates();
    _tabController = TabController(length: 5, vsync: this);

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _tabController.addListener(_handleTabChange);
    _fetchMatchesForSelectedDate();

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _initDates() {
    final today = DateTime.now();
    // Create date tabs: [today-2, today-1, today, today+1, today+2]
    _dateTabs = List.generate(
        5, (index) => DateTime(today.year, today.month, today.day - 1 + index));
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
    // Navigate to match details and ensure all fixture data is fetched by ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsPage(
          fixture: match,
          // Pass this flag to ensure fresh data is fetched from API
          fetchFullDetails: true,
        ),
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
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _isRefreshing = true;
                });

                // Clear cache for current date to force refresh
                _cachedMatches.remove(_selectedDate);
                _fetchMatchesForSelectedDate();

                // Add haptic feedback
                await Future.delayed(const Duration(milliseconds: 1500));

                if (mounted) {
                  setState(() {
                    _isRefreshing = false;
                  });
                }
              },
              child: Column(
                children: [
                  // Enhanced top card with current date
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.sports_soccer,
                                    color: Colors.white,
                                    size: 28,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Fixtures',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 3.0,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: const Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (!_isToday(_selectedDate))
                                    AnimatedScale(
                                      scale: 1.0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: GestureDetector(
                                        onTap: () {
                                          _jumpToTodayTab();
                                          // Add haptic feedback here if available
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.25),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.today,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'Today',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('EEEE, d MMMM yyyy')
                                    .format(_selectedDate),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: _isRefreshing
                                      ? Colors.orange
                                      : Colors.green,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (_isRefreshing
                                              ? Colors.orange
                                              : Colors.green)
                                          .withOpacity(0.5),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isRefreshing
                                    ? 'UPDATING'
                                    : (_isToday(_selectedDate)
                                        ? 'TODAY'
                                        : 'MATCHES'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black26,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), // Enhanced date navigation tabs
                  Container(
                    height: 65,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      dividerColor: Colors.transparent,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                      indicatorPadding: const EdgeInsets.all(4),
                      tabs: _dateTabs.map((date) {
                        final isToday = _isToday(date);
                        final isSelected = _selectedDate.day == date.day &&
                            _selectedDate.month == date.month &&
                            _selectedDate.year == date.year;

                        return Tab(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isToday
                                      ? 'TODAY'
                                      : DateFormat('EEE')
                                          .format(date)
                                          .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: isSelected ? 11 : 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w600,
                                    shadows: isSelected
                                        ? [
                                            const Shadow(
                                              blurRadius: 2.0,
                                              color: Colors.black26,
                                              offset: Offset(0.5, 0.5),
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    DateFormat('dd').format(date),
                                    style: TextStyle(
                                      fontSize: isSelected ? 13 : 12,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      shadows: isSelected
                                          ? [
                                              const Shadow(
                                                blurRadius: 2.0,
                                                color: Colors.black26,
                                                offset: Offset(0.5, 0.5),
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ), // Enhanced matches list
                  Expanded(
                    child: BlocBuilder<LiveMatchesBloc, LiveMatchesState>(
                      builder: (context, state) {
                        if (state is LiveMatchesLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Loading matches for ${DateFormat('d MMM').format(_selectedDate)}...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is LiveMatchesError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .errorContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Oops! Something went wrong',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: _fetchMatchesForSelectedDate,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Try Again'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is LiveMatchesEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    Icons.sports_soccer,
                                    size: 48,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No matches today',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton.icon(
                                  onPressed: _fetchMatchesForSelectedDate,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Refresh'),
                                ),
                              ],
                            ),
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
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Icons.sports_soccer,
                                      size: 48,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No matches today',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No matches scheduled for ${DateFormat('d MMM').format(_selectedDate)}',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return AnimatedList(
                            initialItemCount: sortedLeagueIds.length,
                            itemBuilder: (context, index, animation) {
                              final leagueId = sortedLeagueIds[index];
                              final matches = groupedMatches[leagueId]!;
                              final league = matches.first.league;

                              return SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                    begin: const Offset(0, 0.3),
                                    end: Offset.zero,
                                  ).chain(
                                      CurveTween(curve: Curves.easeOutCubic)),
                                ),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 8.0,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    league.logo,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Icon(
                                                        Icons.sports_soccer,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        size: 20,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      league.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      league.country,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurfaceVariant,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  '${matches.length}',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ...matches.map((match) => MatchCard(
                                              match: match,
                                              onTap: () =>
                                                  _navigateToMatchDetails(
                                                      match),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
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
            ),
          ),
        );
      },
    );
  }
}
