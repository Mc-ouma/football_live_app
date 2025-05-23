import 'dart:convert';

import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/app_database.dart';
import 'package:football_live_app/data/models/fixture_adapter.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/player_model.dart';
import 'package:football_live_app/data/models/standing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class FootballLocalDataSource {
  /// Gets cached live matches
  /// Throws [CacheException] if no cached data is present.
  Future<List<FixtureData>> getCachedLiveMatches();

  /// Cache live matches
  Future<void> cacheLiveMatches(List<FixtureData> fixtures);

  /// Gets cached upcoming fixtures
  Future<List<FixtureData>> getCachedUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
  });

  /// Cache upcoming fixtures
  Future<void> cacheUpcomingFixtures(List<FixtureData> fixtures);

  /// Gets cached match details by ID
  Future<FixtureData> getCachedMatchDetails(int fixtureId);

  /// Cache match details
  Future<void> cacheMatchDetails(FixtureData fixture);

  /// Gets cached league standings
  Future<LeagueStandingModel> getCachedLeagueStandings({
    required int leagueId,
    required int season,
  });

  /// Cache league standings
  Future<void> cacheLeagueStandings(LeagueStandingModel standings);

  /// Gets cached team information
  Future<Team> getCachedTeamInformation(int teamId);

  /// Cache team information
  Future<void> cacheTeamInformation(Team team);

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
  Future<List<League>> getCachedLeagues();

  /// Cache leagues
  Future<void> cacheLeagues(List<League> leagues);

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

  // Cache validity duration in minutes
  static const int CACHE_VALID_DURATION = 120; // 2 hours

  @override
  Future<List<FixtureData>> getCachedLiveMatches() async {
    try {
      if (!await isCacheValid(CACHED_LIVE_MATCHES_TIMESTAMP)) {
        throw CacheException(message: 'Cache expired');
      }

      final jsonString = sharedPreferences.getString(CACHED_LIVE_MATCHES);
      if (jsonString == null || jsonString.isEmpty) {
        throw CacheException(message: 'No cached live matches found');
      }

      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson
          .map<FixtureData>((item) => FixtureData.fromJson(item))
          .toList();
    } catch (e) {
      logger.error('Error retrieving cached live matches', error: e);
      throw CacheException(message: 'Failed to retrieve cached live matches');
    }
  }

  @override
  Future<void> cacheLiveMatches(List<FixtureData> fixtures) async {
    try {
      // Convert fixtures to JSON and save to shared preferences
      final String jsonString =
          json.encode(fixtures.map((fixture) => fixture.toJson()).toList());

      await sharedPreferences.setString(CACHED_LIVE_MATCHES, jsonString);
      await sharedPreferences.setInt(
          CACHED_LIVE_MATCHES_TIMESTAMP, DateTime.now().millisecondsSinceEpoch);

      // Also save to database for more structured access
      final batch = database.batch();
      for (final fixture in fixtures) {
        // Store main fixture data
        batch.insert(
          'fixtures',
          FixtureAdapter.toDatabase(fixture),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Store events if available
        if (fixture.events != null) {
          for (final event in fixture.events!) {
            batch.insert(
              'events',
              {
                'fixture_id': fixture.fixture.id,
                'team_id': event.team.id,
                'player_id': event.player.id,
                'assist_player_id': event.assist?.id,
                'type': event.type,
                'detail': event.detail,
                'time_elapsed': event.time.elapsed,
                'time_extra': event.time.extra,
                'comments': event.comments,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }
      }

      await batch.commit();
      logger.info('Cached ${fixtures.length} live matches successfully');
    } catch (e) {
      logger.error('Error caching live matches', error: e);
      throw CacheException(message: 'Failed to cache live matches');
    }
  }

  @override
  Future<List<FixtureData>> getCachedUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
  }) async {
    try {
      if (!await isCacheValid(CACHED_UPCOMING_FIXTURES_TIMESTAMP)) {
        throw CacheException(message: 'Cache expired');
      }

      // Build query for fetching fixtures from database
      String query = 'SELECT * FROM fixtures WHERE 1=1';
      List<dynamic> args = [];

      if (date != null) {
        final startOfDay =
            DateTime(date.year, date.month, date.day).millisecondsSinceEpoch /
                1000;
        final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
                .millisecondsSinceEpoch /
            1000;
        query += ' AND timestamp BETWEEN ? AND ?';
        args.add(startOfDay);
        args.add(endOfDay);
      }

      if (teamId != null) {
        query += ' AND (home_team_id = ? OR away_team_id = ?)';
        args.add(teamId);
        args.add(teamId);
      }

      if (leagueId != null) {
        query += ' AND league_id = ?';
        args.add(leagueId);
      }

      query += ' ORDER BY timestamp ASC';

      final List<Map<String, dynamic>> maps =
          await database.rawQuery(query, args);

      if (maps.isEmpty) {
        throw CacheException(message: 'No cached upcoming fixtures found');
      }

      final List<FixtureData> fixtures = [];
      for (final map in maps) {
        fixtures.add(FixtureAdapter.fromDatabase(map));
      }

      return fixtures;
    } catch (e) {
      logger.error('Error retrieving cached upcoming fixtures', error: e);
      throw CacheException(
          message: 'Failed to retrieve cached upcoming fixtures');
    }
  }

  @override
  Future<void> cacheUpcomingFixtures(List<FixtureData> fixtures) async {
    try {
      // Convert fixtures to JSON and save to shared preferences
      final String jsonString =
          json.encode(fixtures.map((fixture) => fixture.toJson()).toList());

      await sharedPreferences.setString(CACHED_UPCOMING_FIXTURES, jsonString);
      await sharedPreferences.setInt(CACHED_UPCOMING_FIXTURES_TIMESTAMP,
          DateTime.now().millisecondsSinceEpoch);

      // Also save to database for more structured access
      final batch = database.batch();
      for (final fixture in fixtures) {
        batch.insert(
          'fixtures',
          FixtureAdapter.toDatabase(fixture),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();
      logger.info('Cached ${fixtures.length} upcoming fixtures successfully');
    } catch (e) {
      logger.error('Error caching upcoming fixtures', error: e);
      throw CacheException(message: 'Failed to cache upcoming fixtures');
    }
  }

  @override
  Future<FixtureData> getCachedMatchDetails(int fixtureId) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'fixtures',
        where: 'id = ?',
        whereArgs: [fixtureId],
      );

      if (maps.isEmpty) {
        throw CacheException(message: 'No cached match details found');
      }

      // Create fixture data object
      final FixtureData fixture = FixtureAdapter.fromDatabase(maps.first);

      // Load related events
      final List<Map<String, dynamic>> eventMaps = await database.query(
        'events',
        where: 'fixture_id = ?',
        whereArgs: [fixtureId],
      );

      if (eventMaps.isNotEmpty) {
        final List<Event> events = [];
        for (final eventMap in eventMaps) {
          events.add(Event(
            time: Time(
              elapsed: eventMap['time_elapsed'] as int,
              extra: eventMap['time_extra'] as int?,
            ),
            team: Team(
              id: eventMap['team_id'] as int,
              name: '', // Needs to be loaded from teams table
              logo: '',
            ),
            player: Player(
              id: eventMap['player_id'] as int?,
              name: eventMap['player_name'] as String? ?? '',
            ),
            assist: eventMap['assist_player_id'] != null
                ? Player(
                    id: eventMap['assist_player_id'] as int?,
                    name: eventMap['assist_player_name'] as String? ?? '',
                  )
                : null,
            type: eventMap['type'] as String,
            detail: eventMap['detail'] as String,
            comments: eventMap['comments'] as String?,
          ));
        }

        // Return a new FixtureData with the events included
        return FixtureData(
          fixture: fixture.fixture,
          league: fixture.league,
          teams: fixture.teams,
          goals: fixture.goals,
          score: fixture.score,
          events: events,
          // Other fields remain the same as in fixture
          lineups: fixture.lineups,
          statistics: fixture.statistics,
          players: fixture.players,
        );
      }

      return fixture;
    } catch (e) {
      logger.error('Error retrieving cached match details', error: e);
      throw CacheException(message: 'Failed to retrieve cached match details');
    }
  }

  @override
  Future<void> cacheMatchDetails(FixtureData fixture) async {
    try {
      // Insert fixture details
      await database.insert(
        'fixtures',
        FixtureAdapter.toDatabase(fixture),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert events if available
      if (fixture.events != null) {
        final batch = database.batch();
        // First, delete existing events for this fixture
        batch.delete(
          'events',
          where: 'fixture_id = ?',
          whereArgs: [fixture.fixture.id],
        );

        // Then insert new events
        for (final event in fixture.events!) {
          batch.insert(
            'events',
            {
              'fixture_id': fixture.fixture.id,
              'team_id': event.team.id,
              'player_id': event.player.id,
              'player_name': event.player.name,
              'assist_player_id': event.assist?.id,
              'assist_player_name': event.assist?.name,
              'type': event.type,
              'detail': event.detail,
              'time_elapsed': event.time.elapsed,
              'time_extra': event.time.extra,
              'comments': event.comments,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      }

      // Insert lineups if available
      if (fixture.lineups != null) {
        // Implementation for lineups caching would go here
      }

      // Insert statistics if available
      if (fixture.statistics != null) {
        // Implementation for statistics caching would go here
      }

      logger.info(
          'Cached match details for fixture #${fixture.fixture.id} successfully');
    } catch (e) {
      logger.error('Error caching match details', error: e);
      throw CacheException(message: 'Failed to cache match details');
    }
  }

  @override
  Future<LeagueStandingModel> getCachedLeagueStandings({
    required int leagueId,
    required int season,
  }) async {
    // This depends on the structure of your LeagueStandingModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<void> cacheLeagueStandings(LeagueStandingModel standings) async {
    // This depends on the structure of your LeagueStandingModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Team> getCachedTeamInformation(int teamId) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'teams',
        where: 'id = ?',
        whereArgs: [teamId],
      );

      if (maps.isEmpty) {
        throw CacheException(message: 'No cached team information found');
      }

      return Team(
        id: maps.first['id'] as int,
        name: maps.first['name'] as String,
        logo: maps.first['logo'] as String,
      );
    } catch (e) {
      logger.error('Error retrieving cached team information', error: e);
      throw CacheException(
          message: 'Failed to retrieve cached team information');
    }
  }

  @override
  Future<void> cacheTeamInformation(Team team) async {
    try {
      await database.insert(
        'teams',
        {
          'id': team.id,
          'name': team.name,
          'logo': team.logo,
          'last_updated': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      logger.info('Cached team information for team #${team.id} successfully');
    } catch (e) {
      logger.error('Error caching team information', error: e);
      throw CacheException(message: 'Failed to cache team information');
    }
  }

  @override
  Future<PlayerModel> getCachedPlayerInformation(int playerId) async {
    // This depends on the structure of your PlayerModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<void> cachePlayerInformation(PlayerModel player) async {
    // This depends on the structure of your PlayerModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<PlayerStatisticsModel> getCachedPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
  }) async {
    // This depends on the structure of your PlayerStatisticsModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<void> cachePlayerStatistics(PlayerStatisticsModel playerStats) async {
    // This depends on the structure of your PlayerStatisticsModel
    // Implementation would need to be adapted to your specific models
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<List<League>> getCachedLeagues() async {
    try {
      if (!await isCacheValid(CACHED_LEAGUES_TIMESTAMP)) {
        throw CacheException(message: 'Cache expired');
      }

      final jsonString = sharedPreferences.getString(CACHED_LEAGUES);
      if (jsonString == null || jsonString.isEmpty) {
        throw CacheException(message: 'No cached leagues found');
      }

      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson.map<League>((item) => League.fromJson(item)).toList();
    } catch (e) {
      logger.error('Error retrieving cached leagues', error: e);
      throw CacheException(message: 'Failed to retrieve cached leagues');
    }
  }

  @override
  Future<void> cacheLeagues(List<League> leagues) async {
    try {
      final String jsonString =
          json.encode(leagues.map((league) => league.toJson()).toList());

      await sharedPreferences.setString(CACHED_LEAGUES, jsonString);
      await sharedPreferences.setInt(
          CACHED_LEAGUES_TIMESTAMP, DateTime.now().millisecondsSinceEpoch);

      // Also save to database for more structured access
      final batch = database.batch();
      for (final league in leagues) {
        batch.insert(
          'leagues',
          {
            'id': league.id,
            'name': league.name,
            'country': league.country,
            'logo': league.logo,
            'flag': league.flag,
            'season': league.season,
            'round': league.round,
            'last_updated': DateTime.now().millisecondsSinceEpoch,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();
      logger.info('Cached ${leagues.length} leagues successfully');
    } catch (e) {
      logger.error('Error caching leagues', error: e);
      throw CacheException(message: 'Failed to cache leagues');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Clear shared preferences
      final keys = [
        CACHED_LIVE_MATCHES,
        CACHED_LIVE_MATCHES_TIMESTAMP,
        CACHED_UPCOMING_FIXTURES,
        CACHED_UPCOMING_FIXTURES_TIMESTAMP,
        CACHED_LEAGUES,
        CACHED_LEAGUES_TIMESTAMP,
      ];

      for (final key in keys) {
        await sharedPreferences.remove(key);
      }

      // Clear database tables
      final batch = database.batch();
      batch.delete('fixtures');
      batch.delete('events');
      batch.delete('teams');
      batch.delete('leagues');
      batch.delete('players');
      batch.delete('player_statistics');
      batch.delete('standings');
      await batch.commit();

      logger.info('Cache cleared successfully');
    } catch (e) {
      logger.error('Error clearing cache', error: e);
      throw CacheException(message: 'Failed to clear cache');
    }
  }

  @override
  Future<bool> isCacheValid(String key) async {
    final timestamp = sharedPreferences.getInt(key);
    if (timestamp == null) {
      return false;
    }

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final currentTime = DateTime.now();
    final difference = currentTime.difference(cachedTime).inMinutes;

    return difference < CACHE_VALID_DURATION;
  }

  @override
  Future<String> getLastCacheTime(String key) async {
    final timestamp = sharedPreferences.getInt(key);
    if (timestamp == null) {
      return 'never';
    }

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final currentTime = DateTime.now();
    final difference = currentTime.difference(cachedTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
