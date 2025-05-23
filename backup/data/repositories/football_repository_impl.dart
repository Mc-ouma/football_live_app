import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/football_local_data_source_new.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source_new.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/player_model.dart';
import 'package:football_live_app/data/models/standing_model.dart';
import 'package:football_live_app/domain/entities/fixture.dart';
import 'package:football_live_app/domain/entities/player.dart';
import 'package:football_live_app/domain/entities/standing.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';

class FootballRepositoryImpl implements FootballRepository {
  final FootballRemoteDataSource remoteDataSource;
  final FootballLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final LoggerService logger;

  FootballRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.logger,
  });

  @override
  Future<Either<Failure, List<FixtureData>>> getLiveMatches() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFixtures = await remoteDataSource.getLiveMatches();

        // Cache the fresh data for offline use
        await localDataSource.cacheLiveMatches(remoteFixtures);

        // Log the successful API call
        logger.info(
            'Successfully fetched ${remoteFixtures.length} live matches from API');

        return Right(remoteFixtures);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
            'API rate limit hit, returning cached data: ${e.message}',
            error: e);

        try {
          // Check when the cache was last updated
          final cacheAge =
              await localDataSource.getLastCacheTime('live_matches');
          final localFixtures = await localDataSource.getCachedLiveMatches();

          if (localFixtures.isNotEmpty) {
            logger.info(
                'Using cached data from $cacheAge ago (${localFixtures.length} matches)');
            return Right(localFixtures);
          } else {
            return Left(
                CacheFailure(message: 'No cached live matches available'));
          }
        } on CacheException catch (e) {
          return Left(CacheFailure(message: 'Cache error: ${e.message}'));
        }
      } on ServerException catch (e) {
        logger.error('Server error when fetching live matches', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when fetching live matches', error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final cacheAge = await localDataSource.getLastCacheTime('live_matches');
        final localFixtures = await localDataSource.getCachedLiveMatches();

        if (localFixtures.isNotEmpty) {
          logger.info(
              'Using cached data from $cacheAge ago (${localFixtures.length} matches)');
          return Right(localFixtures);
        } else {
          return Left(
              CacheFailure(message: 'No cached live matches available'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<FixtureData>>> getUpcomingFixtures({
    DateTime? date,
    int? teamId,
    int? leagueId,
    int? season,
    int limit = 10,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFixtures = await remoteDataSource.getUpcomingFixtures(
          date: date,
          teamId: teamId,
          leagueId: leagueId,
          season: season,
          limit: limit,
        );

        // Cache the fresh data for offline use
        await localDataSource.cacheUpcomingFixtures(remoteFixtures);

        // Log the successful API call
        logger.info(
            'Successfully fetched ${remoteFixtures.length} upcoming fixtures from API');

        return Right(remoteFixtures);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
            'API rate limit hit, returning cached data: ${e.message}',
            error: e);

        try {
          // Check when the cache was last updated
          final cacheAge =
              await localDataSource.getLastCacheTime('upcoming_fixtures');
          final localFixtures = await localDataSource.getCachedUpcomingFixtures(
            date: date,
            teamId: teamId,
            leagueId: leagueId,
          );

          if (localFixtures.isNotEmpty) {
            logger.info(
                'Using cached data from $cacheAge ago (${localFixtures.length} fixtures)');
            return Right(localFixtures);
          } else {
            return Left(
                CacheFailure(message: 'No cached upcoming fixtures available'));
          }
        } on CacheException catch (e) {
          return Left(CacheFailure(message: 'Cache error: ${e.message}'));
        }
      } on ServerException catch (e) {
        logger.error('Server error when fetching upcoming fixtures', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when fetching upcoming fixtures',
            error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final cacheAge =
            await localDataSource.getLastCacheTime('upcoming_fixtures');
        final localFixtures = await localDataSource.getCachedUpcomingFixtures(
          date: date,
          teamId: teamId,
          leagueId: leagueId,
        );

        if (localFixtures.isNotEmpty) {
          logger.info(
              'Using cached data from $cacheAge ago (${localFixtures.length} fixtures)');
          return Right(localFixtures);
        } else {
          return Left(
              CacheFailure(message: 'No cached upcoming fixtures available'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, FixtureData>> getMatchDetails(int matchId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFixture = await remoteDataSource.getMatchDetails(matchId);

        // Cache the fresh data for offline use
        await localDataSource.cacheMatchDetails(remoteFixture);

        // Log the successful API call
        logger.info('Successfully fetched match details for match #$matchId');

        return Right(remoteFixture);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
            'API rate limit hit, returning cached data: ${e.message}',
            error: e);

        try {
          // Check if we have cached data for this match
          final localFixture =
              await localDataSource.getCachedMatchDetails(matchId);
          logger.info('Using cached match details for match #$matchId');
          return Right(localFixture);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: 'Cache error: ${e.message}'));
        }
      } on ServerException catch (e) {
        logger.error('Server error when fetching match details', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when fetching match details', error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localFixture =
            await localDataSource.getCachedMatchDetails(matchId);
        logger.info('Using cached match details for match #$matchId');
        return Right(localFixture);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, LeagueStanding>> getLeagueStandings({
    required int leagueId,
    required int season,
  }) async {
    // This implementation needs to be adapted based on your LeagueStanding entity
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Either<Failure, Team>> getTeamInformation(int teamId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTeam = await remoteDataSource.getTeamInformation(teamId);

        // Cache the fresh data for offline use
        await localDataSource.cacheTeamInformation(remoteTeam);

        // Log the successful API call
        logger.info('Successfully fetched team information for team #$teamId');

        return Right(remoteTeam);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
            'API rate limit hit, returning cached data: ${e.message}',
            error: e);

        try {
          // Check if we have cached data for this team
          final localTeam =
              await localDataSource.getCachedTeamInformation(teamId);
          logger.info('Using cached team information for team #$teamId');
          return Right(localTeam);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: 'Cache error: ${e.message}'));
        }
      } on ServerException catch (e) {
        logger.error('Server error when fetching team information', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when fetching team information',
            error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localTeam =
            await localDataSource.getCachedTeamInformation(teamId);
        logger.info('Using cached team information for team #$teamId');
        return Right(localTeam);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> getTeamStatistics({
    required int teamId,
    required int leagueId,
    required int season,
  }) async {
    // Implementation for team statistics
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Either<Failure, Player>> getPlayerInformation(int playerId) async {
    // Implementation for player information
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Either<Failure, PlayerStatistics>> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  }) async {
    // Implementation for player statistics
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Either<Failure, List<Team>>> searchTeams(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTeams = await remoteDataSource.searchTeams(query);

        // Log the successful API call
        logger.info('Successfully searched teams with query: $query');

        return Right(remoteTeams);
      } on ServerException catch (e) {
        logger.error('Server error when searching teams', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when searching teams', error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Player>>> searchPlayers(String query) async {
    // Implementation for player search
    throw UnimplementedError('Not implemented yet');
  }

  @override
  Future<Either<Failure, List<League>>> getLeagues({
    String? country,
    int? season,
    bool current = true,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLeagues = await remoteDataSource.getLeagues(
          country: country,
          season: season,
          current: current,
        );

        // Cache the fresh data for offline use
        await localDataSource.cacheLeagues(remoteLeagues);

        // Log the successful API call
        logger.info('Successfully fetched ${remoteLeagues.length} leagues');

        return Right(remoteLeagues);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
            'API rate limit hit, returning cached data: ${e.message}',
            error: e);

        try {
          // Check if we have cached leagues
          final localLeagues = await localDataSource.getCachedLeagues();
          logger.info('Using ${localLeagues.length} cached leagues');
          return Right(localLeagues);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: 'Cache error: ${e.message}'));
        }
      } on ServerException catch (e) {
        logger.error('Server error when fetching leagues', error: e);
        return Left(ServerFailure(message: e.message, code: e.code));
      } on Exception catch (e) {
        logger.error('Unexpected error when fetching leagues', error: e);
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localLeagues = await localDataSource.getCachedLeagues();
        logger.info('Using ${localLeagues.length} cached leagues');
        return Right(localLeagues);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}
