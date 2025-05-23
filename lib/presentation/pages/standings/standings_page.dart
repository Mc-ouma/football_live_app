import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/domain/entities/standing.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/pages/team_stats/team_stats_page.dart';
import 'package:football_live_app/presentation/widgets/error_view.dart';

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

  // Factory constructor to handle conversion from string to int if needed
  factory StandingsPage.fromAny({
    Key? key,
    required int leagueId,
    required dynamic season,
    required String leagueName,
  }) {
    // Ensure season is an int
    final int seasonInt = season is int ? season : int.parse(season.toString());

    return StandingsPage(
      key: key,
      leagueId: leagueId,
      season: seasonInt,
      leagueName: leagueName,
    );
  }

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  late StandingsBloc _standingsBloc;

  @override
  void initState() {
    super.initState();
    _standingsBloc = sl<StandingsBloc>();
    _standingsBloc.add(FetchStandingsEvent(
      leagueId: widget.leagueId,
      season: widget.season,
    ));
  }

  @override
  void dispose() {
    _standingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.leagueName} Standings'),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _standingsBloc,
        child: BlocBuilder<StandingsBloc, StandingsState>(
          builder: (context, state) {
            if (state is StandingsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StandingsLoaded) {
              return _buildStandingsList(state.standings);
            } else if (state is StandingsEmpty) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is StandingsError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  _standingsBloc.add(FetchStandingsEvent(
                    leagueId: widget.leagueId,
                    season: widget.season,
                  ));
                },
              );
            } else {
              return const Center(
                child: Text('Select a league to view standings'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStandingsList(List<Standing> standings) {
    return ListView.builder(
      itemCount: standings.length,
      itemBuilder: (context, index) {
        final standing = standings[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Text(standing.rank.toString()),
          ),
          title: Text(standing.team.name),
          subtitle: Text(
              '${standing.all?.played ?? 0} matches, ${standing.points} pts'),
          trailing: Text('GD: ${standing.goalsDiff}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamStatsPage(team: standing.team),
              ),
            );
          },
        );
      },
    );
  }
}
