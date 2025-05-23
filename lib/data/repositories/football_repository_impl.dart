import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/football_local_data_source.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
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
        final remoteMatches = await remoteDataSource.getLiveMatches();

        // Cache the fresh data for offline use
        await localDataSource.cacheLiveMatches(remoteMatches);

        // Log the successful API call
        logger.info(
          'Successfully fetched ${remoteMatches.length} live matches from API',
        );

        return Right(remoteMatches);
      } on RateLimitException catch (e) {
        // Log rate limit details for debugging
        logger.warning(
          'API rate limit hit, returning cached data: ${e.message}',
          error: e,
        );

        try {
          // Check when the cache was last updated
          final cacheAge = await localDataSource.getLastCacheTime(
            'live_matches',
          );
          final localMatches = await localDataSource.getCachedLiveMatches();

          if (localMatches.isNotEmpty) {
            logger.info(
              'Using cached data from $cacheAge ago (${localMatches.length} matches)',
            );
            return Right(localMatches);
          } else {
            return Left(
              CacheFailure(message: 'No cached live matches available'),
            );
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
        final localMatches = await localDataSource.getCachedLiveMatches();

        if (localMatches.isNotEmpty) {
          logger.info(
            'Using cached data from $cacheAge ago (${localMatches.length} matches)',
          );
          return Right(localMatches);
        } else {
          return Left(
            CacheFailure(message: 'No cached live matches available'),
          );
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
        await localDataSource.cacheUpcomingFixtures(remoteFixtures);
        return Right(remoteFixtures);
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localFixtures = await localDataSource.getCachedUpcomingFixtures(
            date: date,
            teamId: teamId,
            leagueId: leagueId,
          );
          return Right(localFixtures);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localFixtures = await localDataSource.getCachedUpcomingFixtures(
          date: date,
          teamId: teamId,
          leagueId: leagueId,
        );
        return Right(localFixtures);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, FixtureData>> getMatchDetails(int matchId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMatch = await remoteDataSource.getMatchDetails(matchId);
        await localDataSource.cacheMatchDetails(remoteMatch);
        return Right(remoteMatch);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localMatch = await localDataSource.getCachedMatchDetails(
            matchId,
          );
          return Right(localMatch);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localMatch = await localDataSource.getCachedMatchDetails(matchId);
        return Right(localMatch);
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
    if (await networkInfo.isConnected) {
      try {
        final remoteStandings = await remoteDataSource.getLeagueStandings(
          leagueId: leagueId,
          season: season,
        );
        await localDataSource.cacheLeagueStandings(remoteStandings);
        return Right(remoteStandings);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localStandings = await localDataSource.getCachedLeagueStandings(
            leagueId: leagueId,
            season: season,
          );
          return Right(localStandings);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localStandings = await localDataSource.getCachedLeagueStandings(
          leagueId: leagueId,
          season: season,
        );
        return Right(localStandings);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Team>> getTeamInformation(int teamId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTeam = await remoteDataSource.getTeamInformation(teamId);
        await localDataSource.cacheTeamInformation(remoteTeam);
        return Right(remoteTeam);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localTeam = await localDataSource.getCachedTeamInformation(
            teamId,
          );
          return Right(localTeam);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localTeam = await localDataSource.getCachedTeamInformation(
          teamId,
        );
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
    if (await networkInfo.isConnected) {
      try {
        final remoteStats = await remoteDataSource.getTeamStatistics(
          teamId: teamId,
          leagueId: leagueId,
          season: season,
        );
        return Right(remoteStats);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Player>> getPlayerInformation(int playerId) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePlayer = await remoteDataSource.getPlayerInformation(
          playerId,
        );
        await localDataSource.cachePlayerInformation(remotePlayer);
        return Right(remotePlayer);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localPlayer = await localDataSource.getCachedPlayerInformation(
            playerId,
          );
          return Right(localPlayer);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localPlayer = await localDataSource.getCachedPlayerInformation(
          playerId,
        );
        return Right(localPlayer);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, PlayerStatistics>> getPlayerStatistics({
    required int playerId,
    required int season,
    int? leagueId,
    int? teamId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStats = await remoteDataSource.getPlayerStatistics(
          playerId: playerId,
          season: season,
          leagueId: leagueId,
          teamId: teamId,
        );
        await localDataSource.cachePlayerStatistics(remoteStats);
        return Right(remoteStats);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localStats = await localDataSource.getCachedPlayerStatistics(
            playerId: playerId,
            season: season,
            leagueId: leagueId,
          );
          return Right(localStats);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localStats = await localDataSource.getCachedPlayerStatistics(
          playerId: playerId,
          season: season,
          leagueId: leagueId,
        );
        return Right(localStats);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Team>>> searchTeams(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTeams = await remoteDataSource.searchTeams(query);
        return Right(remoteTeams);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Player>>> searchPlayers(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePlayers = await remoteDataSource.searchPlayers(query);
        return Right(remotePlayers);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
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
        await localDataSource.cacheLeagues(remoteLeagues);
        return Right(remoteLeagues);
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localLeagues = await localDataSource.getCachedLeagues();
          return Right(localLeagues);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localLeagues = await localDataSource.getCachedLeagues();
        return Right(localLeagues);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}
