import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/data/models/standings_model.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';
import 'package:football_live_app/presentation/widgets/loading_indicator.dart';

class StandingsPage extends StatefulWidget {
  final int leagueId;
  final int season;
  final String leagueName;

  const StandingsPage({
    Key? key,
    required this.leagueId,
    required this.season,
    required this.leagueName,
  }) : super(key: key);

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  late StandingsBloc _standingsBloc;

  @override
  void initState() {
    super.initState();
    _standingsBloc = sl<StandingsBloc>();
    _loadStandings();
  }

  void _loadStandings() {
    _standingsBloc.add(
      FetchStandingsEvent(
        leagueId: widget.leagueId,
        season: widget.season,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.leagueName} Standings'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStandings,
          ),
        ],
      ),
      body: BlocBuilder<StandingsBloc, StandingsState>(
        bloc: _standingsBloc,
        builder: (context, state) {
          if (state is StandingsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is StandingsError) {
            return ErrorView(
              message: state.message,
              onRetry: _loadStandings,
            );
          } else if (state is StandingsLoaded) {
            return _buildStandingsList(state.standings);
          } else {
            return const Center(
              child: Text('No standings available'),
            );
          }
        },
      ),
    );
  }

  Widget _buildStandingsList(List<StandingsData> standings) {
    if (standings.isEmpty) {
      return const Center(
        child: Text('No standings available for this league'),
      );
    }

    // Usually we take the first league and its first standings
    final standingGroup = standings.first.league.standings.first;

    return ListView.builder(
      itemCount: standingGroup.length,
      itemBuilder: (context, index) {
        final team = standingGroup[index];
        return ListTile(
          leading: SizedBox(
            width: 30,
            child: (team.team.logo != null)
                ? Image.network(
                    team.team.logo,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.sports_soccer),
                  )
                : const Icon(Icons.sports_soccer),
          ),
          title: Text(team.team.name),
          subtitle: Text(
            'Played: ${team.all.played} | Won: ${team.all.win} | Draw: ${team.all.draw} | Lost: ${team.all.lose}',
          ),
          trailing: Text(
            'Pts: ${team.points}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Don't close the bloc here since it's provided by the DI container
    super.dispose();
  }
}
