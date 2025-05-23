import 'dart:convert';

import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/app_database.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/player_model.dart';
import 'package:football_live_app/data/models/standing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class FootballLocalDataSource {
  /// Gets cached live matches
  /// Throws [CacheException] if no cached data is present.
  Future<List<MatchModel>> getCachedLiveMatches();

  /// Cache live matches
  Future<void> cacheLiveMatches(List<MatchModel> matches);

  /// Gets cached upcoming fixtures
  Future<List<MatchModel>> getCachedUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
  });

  /// Cache upcoming fixtures
  Future<void> cacheUpcomingFixtures(List<MatchModel> fixtures);

  /// Gets cached match details by ID
  Future<MatchModel> getCachedMatchDetails(int matchId);

  /// Cache match details
  Future<void> cacheMatchDetails(MatchModel match);

  /// Gets cached league standings
  Future<LeagueStandingModel> getCachedLeagueStandings({
    required int leagueId,
    required int season,
  });

  /// Cache league standings
  Future<void> cacheLeagueStandings(LeagueStandingModel standings);

  /// Gets cached team information
  Future<TeamModel> getCachedTeamInformation(int teamId);

  /// Cache team information
  Future<void> cacheTeamInformation(TeamModel team);

  /// Gets cached player information
  Future<PlayerModel> getCachedPlayerInformation(int playerId);

  /// Cache player information
  Future<void> cachePlayerInformation(PlayerModel player);

  /// Gets cached player statistics
  Future<PlayerStatisticsModel> getCachedPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
  });

  /// Cache player statistics
  Future<void> cachePlayerStatistics(PlayerStatisticsModel playerStats);

  /// Gets cached leagues
  Future<List<LeagueModel>> getCachedLeagues();

  /// Cache leagues
  Future<void> cacheLeagues(List<LeagueModel> leagues);

  /// Clear all cached data
  Future<void> clearCache();

  /// Check if cache is valid based on cache timestamp
  Future<bool> isCacheValid(String key);

  /// Get the cache age as a human-readable string
  Future<String> getLastCacheTime(String key);
}

class FootballLocalDataSourceImpl implements FootballLocalDataSource {
  final AppDatabase database;
  final SharedPreferences sharedPreferences;
  final LoggerService logger;

  FootballLocalDataSourceImpl({
    required this.database,
    required this.sharedPreferences,
    required this.logger,
  });

  // Keys for SharedPreferences
  static const CACHED_LIVE_MATCHES = 'CACHED_LIVE_MATCHES';
  static const CACHED_LIVE_MATCHES_TIMESTAMP = 'CACHED_LIVE_MATCHES_TIMESTAMP';
  static const CACHED_UPCOMING_FIXTURES = 'CACHED_UPCOMING_FIXTURES';
  static const CACHED_UPCOMING_FIXTURES_TIMESTAMP =
      'CACHED_UPCOMING_FIXTURES_TIMESTAMP';
  static const CACHED_LEAGUES = 'CACHED_LEAGUES';
  static const CACHED_LEAGUES_TIMESTAMP = 'CACHED_LEAGUES_TIMESTAMP';

  // Cache duration in minutes
  final cacheDuration = EnvConfig.cacheDuration;

  @override
  Future<bool> isCacheValid(String key) async {
    final timestamp = sharedPreferences.getInt('${key}_TIMESTAMP');
    if (timestamp == null) return false;

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(cachedTime).inMinutes;

    return difference < cacheDuration;
  }

  @override
  Future<String> getLastCacheTime(String key) async {
    final timestamp = sharedPreferences.getInt('${key}_TIMESTAMP');
    if (timestamp == null) {
      throw CacheException(message: 'No cache timestamp found for $key');
    }

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(cachedTime);

    // Return a human-readable format based on the time difference
    if (difference.inDays > 0) {
      return '${difference.inDays} day(s)';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s)';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s)';
    } else {
      return 'just now';
    }
  }

  @override
  Future<List<MatchModel>> getCachedLiveMatches() async {
    try {
      if (!await isCacheValid(CACHED_LIVE_MATCHES)) {
        throw CacheException(message: 'Live matches cache is not valid');
      }

      final jsonString = sharedPreferences.getString(CACHED_LIVE_MATCHES);
      if (jsonString == null) {
        throw CacheException(message: 'No cached live matches found');
      }

      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson
          .map<MatchModel>((item) => MatchModel.fromJson(item))
          .toList();
    } catch (e) {
      logger.error('Error getting cached live matches', error: e);
      throw CacheException(message: 'Failed to get cached live matches: $e');
    }
  }

  @override
  Future<void> cacheLiveMatches(List<MatchModel> matches) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          matches.map((match) => match.toJson()).toList();

      await sharedPreferences.setString(
        CACHED_LIVE_MATCHES,
        json.encode(jsonList),
      );

      await sharedPreferences.setInt(
        CACHED_LIVE_MATCHES_TIMESTAMP,
        DateTime.now().millisecondsSinceEpoch,
      );

      // Also save to database
      final db = await database.database;
      final batch = db.batch();

      for (var match in matches) {
        // Save teams
        batch.insert(
          'teams',
          (match.homeTeam as TeamModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        batch.insert(
          'teams',
          (match.awayTeam as TeamModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Save league
        batch.insert(
          'leagues',
          (match.league as LeagueModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Save fixture/match
        batch.insert(
          'fixtures',
          match.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();
    } catch (e) {
      logger.error('Error caching live matches', error: e);
      throw CacheException(message: 'Failed to cache live matches: $e');
    }
  }

  @override
  Future<List<MatchModel>> getCachedUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
  }) async {
    try {
      if (!await isCacheValid(CACHED_UPCOMING_FIXTURES)) {
        throw CacheException(message: 'Upcoming fixtures cache is not valid');
      }

      final db = await database.database;
      String whereClause =
          'status_short != "FT" AND status_short != "AET" AND status_short != "PEN"';

      final List<String> whereConditions = [];
      final List<dynamic> whereArgs = [];

      if (date != null) {
        final startOfDay =
            DateTime(date.year, date.month, date.day).millisecondsSinceEpoch ~/
                1000;
        final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
                .millisecondsSinceEpoch ~/
            1000;
        whereConditions.add('timestamp BETWEEN ? AND ?');
        whereArgs.addAll([startOfDay, endOfDay]);
      }

      if (teamId != null) {
        whereConditions.add('(home_team_id = ? OR away_team_id = ?)');
        whereArgs.addAll([teamId, teamId]);
      }

      if (leagueId != null) {
        whereConditions.add('league_id = ?');
        whereArgs.add(leagueId);
      }

      if (whereConditions.isNotEmpty) {
        whereClause += ' AND ' + whereConditions.join(' AND ');
      }

      final List<Map<String, dynamic>> maps = await db.query(
        'fixtures',
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'date ASC',
      );

      if (maps.isEmpty) {
        throw CacheException(message: 'No cached upcoming fixtures found');
      }

      final List<MatchModel> fixtures = [];

      for (var map in maps) {
        final match = MatchModel.fromDatabase(map);

        // Load team details
        final homeTeamMap = await db.query(
          'teams',
          where: 'id = ?',
          whereArgs: [map['home_team_id']],
          limit: 1,
        );

        final awayTeamMap = await db.query(
          'teams',
          where: 'id = ?',
          whereArgs: [map['away_team_id']],
          limit: 1,
        );

        // Load league details
        final leagueMap = await db.query(
          'leagues',
          where: 'id = ?',
          whereArgs: [map['league_id']],
          limit: 1,
        );

        // Recreate full match model with related data
        fixtures.add(
          MatchModel(
            id: match.id,
            referee: match.referee,
            timezone: match.timezone,
            date: match.date,
            timestamp: match.timestamp,
            venue: match.venue is VenueModel
                ? (match.venue as VenueModel)
                : VenueModel(
                    id: match.venue.id,
                    name: match.venue.name,
                    city: match.venue.city,
                    country: match.venue.country,
                    capacity: match.venue.capacity,
                    image: match.venue.image,
                    address: match.venue.address,
                  ),
            status: match.status is MatchStatusModel
                ? (match.status as MatchStatusModel)
                : MatchStatusModel(
                    long: match.status.long,
                    short: match.status.short,
                    elapsed: match.status.elapsed,
                  ),
            league: homeTeamMap.isNotEmpty
                ? LeagueModel.fromJson(
                    {'id': leagueMap[0]['id'], 'name': leagueMap[0]['name']})
                : (match.league as LeagueModel),
            homeTeam: homeTeamMap.isNotEmpty
                ? TeamModel.fromJson({
                    'id': homeTeamMap[0]['id'],
                    'name': homeTeamMap[0]['name']
                  }, isHome: true)
                : (match.homeTeam as TeamModel),
            awayTeam: awayTeamMap.isNotEmpty
                ? TeamModel.fromJson({
                    'id': awayTeamMap[0]['id'],
                    'name': awayTeamMap[0]['name']
                  })
                : (match.awayTeam as TeamModel),
            score: match.score != null
                ? (match.score is ScoreModel
                    ? (match.score as ScoreModel)
                    : ScoreModel(
                        homeGoals: match.score?.homeGoals,
                        awayGoals: match.score?.awayGoals,
                        halftime: match.score?.halftime != null
                            ? HalfTimeScoreModel(
                                home: match.score?.halftime?.home,
                                away: match.score?.halftime?.away,
                              )
                            : null,
                        fulltime: match.score?.fulltime != null
                            ? FullTimeScoreModel(
                                home: match.score?.fulltime?.home,
                                away: match.score?.fulltime?.away,
                              )
                            : null,
                        extratime: match.score?.extratime != null
                            ? ExtraTimeScoreModel(
                                home: match.score?.extratime?.home,
                                away: match.score?.extratime?.away,
                              )
                            : null,
                        penalty: match.score?.penalty != null
                            ? PenaltyScoreModel(
                                home: match.score?.penalty?.home,
                                away: match.score?.penalty?.away,
                              )
                            : null,
                      ))
                : null,
          ),
        );
      }

      return fixtures;
    } catch (e) {
      logger.error('Error getting cached upcoming fixtures', error: e);
      throw CacheException(
          message: 'Failed to get cached upcoming fixtures: $e');
    }
  }

  @override
  Future<void> cacheUpcomingFixtures(List<MatchModel> fixtures) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          fixtures.map((fixture) => fixture.toJson()).toList();

      await sharedPreferences.setString(
        CACHED_UPCOMING_FIXTURES,
        json.encode(jsonList),
      );

      await sharedPreferences.setInt(
        CACHED_UPCOMING_FIXTURES_TIMESTAMP,
        DateTime.now().millisecondsSinceEpoch,
      );

      // Also save to database
      final db = await database.database;
      final batch = db.batch();

      for (var fixture in fixtures) {
        // Save teams
        batch.insert(
          'teams',
          (fixture.homeTeam as TeamModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        batch.insert(
          'teams',
          (fixture.awayTeam as TeamModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Save league
        batch.insert(
          'leagues',
          (fixture.league as LeagueModel).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Save fixture/match
        batch.insert(
          'fixtures',
          fixture.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();
    } catch (e) {
      logger.error('Error caching upcoming fixtures', error: e);
      throw CacheException(message: 'Failed to cache upcoming fixtures: $e');
    }
  }

  @override
  Future<MatchModel> getCachedMatchDetails(int matchId) async {
    try {
      final db = await database.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'fixtures',
        where: 'id = ?',
        whereArgs: [matchId],
      );

      if (maps.isEmpty) {
        throw CacheException(
            message: 'No cached match details found for ID: $matchId');
      }

      final match = MatchModel.fromDatabase(maps.first);

      // Load team details
      final homeTeamMap = await db.query(
        'teams',
        where: 'id = ?',
        whereArgs: [maps.first['home_team_id']],
        limit: 1,
      );

      final awayTeamMap = await db.query(
        'teams',
        where: 'id = ?',
        whereArgs: [maps.first['away_team_id']],
        limit: 1,
      );

      // Load league details
      final leagueMap = await db.query(
        'leagues',
        where: 'id = ?',
        whereArgs: [maps.first['league_id']],
        limit: 1,
      );

      // Recreate full match model with related data
      return MatchModel(
        id: match.id,
        referee: match.referee,
        timezone: match.timezone,
        date: match.date,
        timestamp: match.timestamp,
        venue: match.venue is VenueModel
            ? (match.venue as VenueModel)
            : VenueModel(
                id: match.venue.id,
                name: match.venue.name,
                city: match.venue.city,
                country: match.venue.country,
                capacity: match.venue.capacity,
                image: match.venue.image,
                address: match.venue.address,
              ),
        status: match.status is MatchStatusModel
            ? (match.status as MatchStatusModel)
            : MatchStatusModel(
                long: match.status.long,
                short: match.status.short,
                elapsed: match.status.elapsed,
              ),
        league: LeagueModel.fromJson({
          'id': leagueMap[0]['id'],
          'name': leagueMap[0]['name'],
          'country': leagueMap[0]['country'],
          'logo': leagueMap[0]['logo'],
        }),
        homeTeam: TeamModel.fromJson({
          'id': homeTeamMap[0]['id'],
          'name': homeTeamMap[0]['name'],
          'logo': homeTeamMap[0]['logo'],
        }, isHome: true),
        awayTeam: TeamModel.fromJson({
          'id': awayTeamMap[0]['id'],
          'name': awayTeamMap[0]['name'],
          'logo': awayTeamMap[0]['logo'],
        }),
        score: match.score != null
            ? (match.score is ScoreModel
                ? (match.score as ScoreModel)
                : ScoreModel(
                    homeGoals: match.score?.homeGoals,
                    awayGoals: match.score?.awayGoals,
                    halftime: match.score?.halftime != null
                        ? HalfTimeScoreModel(
                            home: match.score?.halftime?.home,
                            away: match.score?.halftime?.away,
                          )
                        : null,
                    fulltime: match.score?.fulltime != null
                        ? FullTimeScoreModel(
                            home: match.score?.fulltime?.home,
                            away: match.score?.fulltime?.away,
                          )
                        : null,
                    extratime: match.score?.extratime != null
                        ? ExtraTimeScoreModel(
                            home: match.score?.extratime?.home,
                            away: match.score?.extratime?.away,
                          )
                        : null,
                    penalty: match.score?.penalty != null
                        ? PenaltyScoreModel(
                            home: match.score?.penalty?.home,
                            away: match.score?.penalty?.away,
                          )
                        : null,
                  ))
            : null,
      );
    } catch (e) {
      logger.error('Error getting cached match details', error: e);
      throw CacheException(message: 'Failed to get cached match details: $e');
    }
  }

  @override
  Future<void> cacheMatchDetails(MatchModel match) async {
    try {
      final db = await database.database;
      final batch = db.batch();

      // Save teams
      batch.insert(
        'teams',
        (match.homeTeam as TeamModel).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      batch.insert(
        'teams',
        (match.awayTeam as TeamModel).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Save league
      batch.insert(
        'leagues',
        (match.league as LeagueModel).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Save fixture/match
      batch.insert(
        'fixtures',
        match.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await batch.commit();
    } catch (e) {
      logger.error('Error caching match details', error: e);
      throw CacheException(message: 'Failed to cache match details: $e');
    }
  }

  @override
  Future<LeagueStandingModel> getCachedLeagueStandings({
    required int leagueId,
    required int season,
  }) async {
    try {
      final db = await database.database;

      // Get league info
      final List<Map<String, dynamic>> leagueMaps = await db.query(
        'leagues',
        where: 'id = ?',
        whereArgs: [leagueId],
        limit: 1,
      );

      if (leagueMaps.isEmpty) {
        throw CacheException(
            message: 'League with ID $leagueId not found in cache');
      }

      // Get standings for this league
      final List<Map<String, dynamic>> standingMaps = await db.query(
        'standings',
        where: 'league_id = ?',
        whereArgs: [leagueId],
        orderBy: 'rank ASC',
      );

      if (standingMaps.isEmpty) {
        throw CacheException(
            message: 'No standings found for league $leagueId in cache');
      }

      // Process standings
      final List<StandingModel> standings = [];
      for (var standingMap in standingMaps) {
        // Get team for this standing
        final List<Map<String, dynamic>> teamMaps = await db.query(
          'teams',
          where: 'id = ?',
          whereArgs: [standingMap['team_id']],
          limit: 1,
        );

        if (teamMaps.isEmpty) continue;

        final TeamModel team = TeamModel(
          id: teamMaps[0]['id'],
          name: teamMaps[0]['name'],
          logo: teamMaps[0]['logo'],
          country: teamMaps[0]['country'],
        );

        standings.add(StandingModel(
          rank: standingMap['rank'],
          team: team,
          points: standingMap['points'],
          description: standingMap['description'],
          form: standingMap['form'],
          all: StandingStatsModel(
            played: standingMap['played'],
            win: standingMap['win'],
            draw: standingMap['draw'],
            lose: standingMap['lose'],
            goals: GoalsModel(
              forGoals: standingMap['goals_for'],
              against: standingMap['goals_against'],
            ),
          ),
          goalsDiff: standingMap['goal_diff'],
        ));
      }

      // Create league model
      final LeagueModel league = LeagueModel(
        id: leagueMaps[0]['id'],
        name: leagueMaps[0]['name'],
        country: leagueMaps[0]['country'],
        logo: leagueMaps[0]['logo'],
        flag: leagueMaps[0]['flag'],
        season: season,
      );

      // Construct the league standing model
      return LeagueStandingModel(
        league: league,
        standings: [standings],
      );
    } catch (e) {
      logger.error('Error getting cached league standings', error: e);
      throw CacheException(
          message: 'Failed to get cached league standings: $e');
    }
  }

  @override
  Future<void> cacheLeagueStandings(LeagueStandingModel standings) async {
    try {
      final db = await database.database;
      final batch = db.batch();
      final LeagueModel league = standings.league as LeagueModel;

      // Save league
      batch.insert(
        'leagues',
        league.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Process all standings
      for (var standingGroup in standings.standings) {
        for (var standing in standingGroup) {
          final StandingModel standingModel = standing as StandingModel;
          final TeamModel team = standingModel.team as TeamModel;

          // Save team
          batch.insert(
            'teams',
            team.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          // Save standing
          final standingMap = standingModel.toMap();
          standingMap['league_id'] = league.id;

          batch.insert(
            'standings',
            standingMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      await batch.commit();
    } catch (e) {
      logger.error('Error caching league standings', error: e);
      throw CacheException(message: 'Failed to cache league standings: $e');
    }
  }

  @override
  Future<TeamModel> getCachedTeamInformation(int teamId) async {
    try {
      final db = await database.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'teams',
        where: 'id = ?',
        whereArgs: [teamId],
        limit: 1,
      );

      if (maps.isEmpty) {
        throw CacheException(
            message: 'Team with ID $teamId not found in cache');
      }

      return TeamModel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        logo: maps[0]['logo'],
        country: maps[0]['country'],
        founded: maps[0]['founded'],
      );
    } catch (e) {
      logger.error('Error getting cached team information', error: e);
      throw CacheException(
          message: 'Failed to get cached team information: $e');
    }
  }

  @override
  Future<void> cacheTeamInformation(TeamModel team) async {
    try {
      final db = await database.database;
      await db.insert(
        'teams',
        team.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      logger.error('Error caching team information', error: e);
      throw CacheException(message: 'Failed to cache team information: $e');
    }
  }

  @override
  Future<PlayerModel> getCachedPlayerInformation(int playerId) async {
    try {
      final db = await database.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'players',
        where: 'id = ?',
        whereArgs: [playerId],
        limit: 1,
      );

      if (maps.isEmpty) {
        throw CacheException(
            message: 'Player with ID $playerId not found in cache');
      }

      return PlayerModel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        firstname: maps[0]['firstname'],
        lastname: maps[0]['lastname'],
        age: maps[0]['age'],
        nationality: maps[0]['nationality'],
        height: maps[0]['height'],
        weight: maps[0]['weight'],
        injured: maps[0]['injured'] == 1,
        photo: maps[0]['photo'],
      );
    } catch (e) {
      logger.error('Error getting cached player information', error: e);
      throw CacheException(
          message: 'Failed to get cached player information: $e');
    }
  }

  @override
  Future<void> cachePlayerInformation(PlayerModel player) async {
    try {
      final db = await database.database;
      await db.insert(
        'players',
        player.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      logger.error('Error caching player information', error: e);
      throw CacheException(message: 'Failed to cache player information: $e');
    }
  }

  @override
  Future<PlayerStatisticsModel> getCachedPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
  }) async {
    try {
      final db = await database.database;

      // Build the query conditions
      final whereConditions = ['player_id = ? AND season = ?'];
      final whereArgs = [playerId, season];

      if (leagueId != null) {
        whereConditions.add('league_id = ?');
        whereArgs.add(leagueId);
      }

      // Get player stats
      final List<Map<String, dynamic>> statsMaps = await db.query(
        'player_stats',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        limit: 1,
      );

      if (statsMaps.isEmpty) {
        throw CacheException(
          message: 'No stats found for player $playerId, season $season',
        );
      }

      // Get player info
      final List<Map<String, dynamic>> playerMaps = await db.query(
        'players',
        where: 'id = ?',
        whereArgs: [playerId],
        limit: 1,
      );

      if (playerMaps.isEmpty) {
        throw CacheException(
            message: 'Player with ID $playerId not found in cache');
      }

      // Create the player model
      final player = PlayerModel(
        id: playerMaps[0]['id'],
        name: playerMaps[0]['name'],
        firstname: playerMaps[0]['firstname'],
        lastname: playerMaps[0]['lastname'],
        age: playerMaps[0]['age'],
        nationality: playerMaps[0]['nationality'],
        height: playerMaps[0]['height'],
        weight: playerMaps[0]['weight'],
        injured: playerMaps[0]['injured'] == 1,
        photo: playerMaps[0]['photo'],
      );

      // Create the stats model
      return PlayerStatisticsModel(
        player: player,
        teamId: statsMaps[0]['team_id'],
        leagueId: statsMaps[0]['league_id'],
        season: statsMaps[0]['season'],
        games: PlayerGamesModel(
          appearences: statsMaps[0]['appearances'],
          lineups: statsMaps[0]['lineups'],
          minutes: statsMaps[0]['minutes'],
        ),
        goals: PlayerGoalsModel(
          total: statsMaps[0]['goals'],
          assists: statsMaps[0]['assists'],
        ),
        cards: PlayerCardsModel(
          yellow: statsMaps[0]['yellowcards'],
          yellowred: statsMaps[0]['yellowred'],
          red: statsMaps[0]['redcards'],
        ),
      );
    } catch (e) {
      logger.error('Error getting cached player statistics', error: e);
      throw CacheException(
          message: 'Failed to get cached player statistics: $e');
    }
  }

  @override
  Future<void> cachePlayerStatistics(PlayerStatisticsModel playerStats) async {
    try {
      final db = await database.database;
      final batch = db.batch();

      // Save player information
      batch.insert(
        'players',
        (playerStats.player as PlayerModel).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Save player stats
      batch.insert(
        'player_stats',
        playerStats.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await batch.commit();
    } catch (e) {
      logger.error('Error caching player statistics', error: e);
      throw CacheException(message: 'Failed to cache player statistics: $e');
    }
  }

  @override
  Future<List<LeagueModel>> getCachedLeagues() async {
    try {
      if (!await isCacheValid(CACHED_LEAGUES)) {
        throw CacheException(message: 'Leagues cache is not valid');
      }

      final jsonString = sharedPreferences.getString(CACHED_LEAGUES);
      if (jsonString == null) {
        throw CacheException(message: 'No cached leagues found');
      }

      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson
          .map<LeagueModel>((item) => LeagueModel.fromJson(item))
          .toList();
    } catch (e) {
      logger.error('Error getting cached leagues', error: e);
      throw CacheException(message: 'Failed to get cached leagues: $e');
    }
  }

  @override
  Future<void> cacheLeagues(List<LeagueModel> leagues) async {
    try {
      final List<Map<String, dynamic>> jsonList =
          leagues.map((league) => league.toJson()).toList();

      await sharedPreferences.setString(
        CACHED_LEAGUES,
        json.encode(jsonList),
      );

      await sharedPreferences.setInt(
        CACHED_LEAGUES_TIMESTAMP,
        DateTime.now().millisecondsSinceEpoch,
      );

      // Also save to database
      final db = await database.database;
      final batch = db.batch();

      for (var league in leagues) {
        batch.insert(
          'leagues',
          league.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();
    } catch (e) {
      logger.error('Error caching leagues', error: e);
      throw CacheException(message: 'Failed to cache leagues: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await database.clearDatabase();

      // Clear SharedPreferences
      await sharedPreferences.remove(CACHED_LIVE_MATCHES);
      await sharedPreferences.remove(CACHED_LIVE_MATCHES_TIMESTAMP);
      await sharedPreferences.remove(CACHED_UPCOMING_FIXTURES);
      await sharedPreferences.remove(CACHED_UPCOMING_FIXTURES_TIMESTAMP);
      await sharedPreferences.remove(CACHED_LEAGUES);
      await sharedPreferences.remove(CACHED_LEAGUES_TIMESTAMP);
    } catch (e) {
      logger.error('Error clearing cache', error: e);
      throw CacheException(message: 'Failed to clear cache: $e');
    }
  }
}
