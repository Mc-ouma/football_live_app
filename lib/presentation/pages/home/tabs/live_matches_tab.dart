import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/pages/match_details/match_details_page.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';
import 'package:football_live_app/presentation/widgets/loading_indicator.dart';
import 'package:football_live_app/presentation/widgets/match_card.dart';
import 'package:football_live_app/presentation/widgets/no_data_view.dart';
import 'package:intl/intl.dart';

class LiveMatchesTab extends StatefulWidget {
  const LiveMatchesTab({super.key});

  @override
  State<LiveMatchesTab> createState() => _LiveMatchesTabState();
}

class _LiveMatchesTabState extends State<LiveMatchesTab> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _fetchLiveMatches();
  }

  void _fetchLiveMatches() {
    try {
      // Just use the current bloc context
      context.read<LiveMatchesBloc>().add(FetchLiveMatchesEvent());
    } catch (e) {
      debugPrint('Error fetching live matches: $e');
    }
  }

  void _navigateToMatchDetails(Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsPage(matchId: match.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: () async {
        _fetchLiveMatches();
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
                    Text(
                      'Today',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
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
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
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

          // Matches list
          Expanded(
            child: BlocBuilder<LiveMatchesBloc, LiveMatchesState>(
              builder: (context, state) {
                if (state is LiveMatchesLoading) {
                  return const LoadingIndicator(
                      message: 'Loading live matches...');
                } else if (state is LiveMatchesError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: _fetchLiveMatches,
                  );
                } else if (state is LiveMatchesEmpty) {
                  return NoDataView(
                    message: state.message,
                    icon: Icons.sports_soccer,
                    onRefresh: _fetchLiveMatches,
                  );
                } else if (state is LiveMatchesLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.matches.length,
                    itemBuilder: (context, index) {
                      final match = state.matches[index];
                      return MatchCard(
                        match: match,
                        onTap: () => _navigateToMatchDetails(match),
                      );
                    },
                  );
                }

                // Initial state
                return const LoadingIndicator(
                    message: 'Fetching live matches...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
