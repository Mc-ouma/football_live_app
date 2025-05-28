import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/core/utils/cache_strategy.dart';
import 'package:football_live_app/data/datasources/local/football_local_data_source.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
import 'package:football_live_app/data/models/fixture_model.dart';
import 'package:football_live_app/data/models/prediction_model.dart';
import 'package:football_live_app/data/models/shared_models.dart'; // Use Team from shared_models
import 'package:football_live_app/data/models/standings_model.dart'
    hide Team; // Hide Team from standings_model
import 'package:football_live_app/domain/repositories/football_repository.dart';

class FootballRepositoryImpl implements FootballRepository {
  final FootballRemoteDataSource remoteDataSource;
  final FootballLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final LoggerService logger;
  final CacheStrategy _cacheStrategy;

  FootballRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.logger,
    CacheStrategy? cacheStrategy,
  }) : _cacheStrategy = cacheStrategy ?? CacheStrategy(logger: logger);

  @override
  Future<Either<Failure, List<FixtureData>>> getLiveMatches() async {
    if (await networkInfo.isConnected) {
      try {
        // Check cache age to implement smart request strategy
        Duration cacheAge = Duration.zero;
        List<FixtureData> localMatches = [];
        bool hasCachedData = false;

        try {
          final cacheTimeString =
              await localDataSource.getLastCacheTime('live_matches');
          // Convert the cache time string to a Duration
          if (cacheTimeString.contains('minutes')) {
            final minutes = int.tryParse(cacheTimeString.split(' ').first) ?? 0;
            cacheAge = Duration(minutes: minutes);
          } else if (cacheTimeString.contains('hours')) {
            final hours = int.tryParse(cacheTimeString.split(' ').first) ?? 0;
            cacheAge = Duration(hours: hours);
          } else if (cacheTimeString.contains('days')) {
            final days = int.tryParse(cacheTimeString.split(' ').first) ?? 0;
            cacheAge = Duration(days: days);
          }

          localMatches = await localDataSource.getCachedLiveMatches();
          hasCachedData = localMatches.isNotEmpty;
        } on CacheException catch (_) {
          // If there's no cache or cache error, we'll proceed with API call
        }

        // Live matches are high priority, but we still respect rate limits
        final endpoint = '/fixtures?live=all';
        final shouldFetch = _cacheStrategy.shouldMakeRequest(
                endpoint, CacheDataType.liveMatch, cacheAge,
                isHighPriority: true) &&
            _shouldMakeRequest('live_matches', cacheAge, hasCachedData,
                true // live matches are high priority
                );

        if (!shouldFetch && hasCachedData) {
          logger.info(
            'Using cached live matches from ${cacheAge.inMinutes} minutes ago (${localMatches.length} matches)',
          );
          return Right(localMatches);
        }

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
  Future<Either<Failure, List<FixtureData>>> getMatchDetails(
      int matchId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMatches = await remoteDataSource.getMatchDetails(matchId);

        // Cache each match individually (since we now handle multiple matches)
        for (final match in remoteMatches) {
          await localDataSource.cacheMatchDetails(match);
        }

        return Right(remoteMatches);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          // When handling from cache, we'll need to adapt the local data source
          // to return a list of matches for the given ID
          final localMatch = await localDataSource.getCachedMatchDetails(
            matchId,
          );
          // Return as a list for consistency
          return Right([localMatch]);
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
        // Return as a list for consistency
        return Right([localMatch]);
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
        return Right(remoteTeam);
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on RateLimitException catch (e) {
        return Left(
            ServerFailure(message: 'Rate limit exceeded: ${e.message}'));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
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
  Future<Either<Failure, List<Team>>> searchTeams(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTeams = await remoteDataSource.searchTeams(query);
        // Convert from shared_models.Team to standings_model.Team if needed
        final convertedTeams = remoteTeams
            .map((sharedTeam) =>
                // Create a new Team instance from standings_model.dart
                Team(
                  id: sharedTeam.id,
                  name: sharedTeam.name,
                  logo: sharedTeam.logo,
                  // Add any other required fields from standings_model.Team
                ))
            .toList();

        return Right(convertedTeams);
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

  @override
  Future<Either<Failure, List<StandingsData>>> getStandings({
    required int leagueId,
    required int season,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStandings = await remoteDataSource.getStandings(
          leagueId: leagueId,
          season: season,
        );
        await localDataSource.cacheStandings(remoteStandings, leagueId, season);
        return Right(remoteStandings);
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localStandings =
              await localDataSource.getCachedStandings(leagueId, season);
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
        final localStandings =
            await localDataSource.getCachedStandings(leagueId, season);
        return Right(localStandings);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<PredictionData>>> getMatchPredictions(
      List<int> matchIds) async {
    if (await networkInfo.isConnected) {
      try {
        // Check cache status before making API calls
        Duration cacheAge = Duration.zero;
        List<PredictionData> localPredictions = [];
        bool hasCachedData = false;

        try {
          // We don't have a specific method for prediction cache time,
          // so we'll just check if we have cached predictions
          localPredictions =
              await localDataSource.getCachedMatchPredictions(matchIds);
          hasCachedData = localPredictions.isNotEmpty;

          // If we have cached data, approximate the cache age
          if (hasCachedData) {
            final cacheTimeString =
                await localDataSource.getLastCacheTime('predictions');
            if (cacheTimeString.contains('minutes')) {
              final minutes =
                  int.tryParse(cacheTimeString.split(' ').first) ?? 0;
              cacheAge = Duration(minutes: minutes);
            } else if (cacheTimeString.contains('hours')) {
              final hours = int.tryParse(cacheTimeString.split(' ').first) ?? 0;
              cacheAge = Duration(hours: hours);
            } else if (cacheTimeString.contains('days')) {
              final days = int.tryParse(cacheTimeString.split(' ').first) ?? 0;
              cacheAge = Duration(days: days);
            }
          }
        } on CacheException catch (_) {
          // No cache available, we'll need to make the API call
        }

        // Predictions are not as high priority as live scores
        final endpoint = '/predictions';
        final shouldFetch = _cacheStrategy.shouldMakeRequest(
                endpoint, CacheDataType.prediction, cacheAge,
                isHighPriority: false) &&
            _shouldMakeRequest('predictions', cacheAge, hasCachedData,
                false // predictions aren't high priority
                );

        // If we have cached data and shouldn't fetch new data, return cached
        if (!shouldFetch && hasCachedData) {
          logger.info(
            'Using cached predictions (${localPredictions.length} predictions)',
          );
          return Right(localPredictions);
        }

        // We need fresh data, make the API call
        final remotePredictions =
            await remoteDataSource.getMatchPredictionsData(matchIds);
        await localDataSource.cacheMatchPredictions(remotePredictions);

        logger.info(
          'Successfully fetched ${remotePredictions.length} predictions from API',
        );
        return Right(remotePredictions);
      } on RateLimitException catch (e) {
        logger.warning('API rate limit hit, returning cached data', error: e);
        try {
          final localPredictions =
              await localDataSource.getCachedMatchPredictions(matchIds);
          return Right(localPredictions);
        } on CacheException catch (e) {
          return Left(CacheFailure(message: e.message));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message, code: e.code));
      }
    } else {
      logger.info('No internet connection, trying to fetch from local cache');
      try {
        final localPredictions =
            await localDataSource.getCachedMatchPredictions(matchIds);
        return Right(localPredictions);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  /// Determines if a request should be made based on rate limiting status
  /// Consider the importance of the feature, the remaining API calls,
  /// and whether we have cached data
  bool _shouldMakeRequest(
    String endpointType,
    Duration cacheAge,
    bool hasCachedData,
    bool isHighPriority,
  ) {
    // We'll allow these feature types to make API requests even when nearing limits
    const highPriorityFeatures = ['live_matches', 'match_details'];

    if (highPriorityFeatures.contains(endpointType) || isHighPriority) {
      // High priority features get preferential treatment
      return true;
    }

    // For lower priority features like predictions, standings, etc.,
    // prefer cache when available and relatively fresh
    if (hasCachedData) {
      switch (endpointType) {
        case 'predictions':
          // Predictions don't change much over time
          if (cacheAge.inHours < 12) {
            return false; // Use cache if less than 12 hours old
          }
          break;
        case 'standings':
          // Standings update daily at most
          if (cacheAge.inHours < 24) {
            return false; // Use cache if less than 24 hours old
          }
          break;
        case 'leagues':
          // League data rarely changes
          if (cacheAge.inDays < 7) {
            return false; // Use cache if less than 7 days old
          }
          break;
        case 'fixtures':
          // Fixtures can be updated more frequently
          if (cacheAge.inHours < 4) {
            return false; // Use cache if less than 4 hours old
          }
          break;
        default:
          if (cacheAge.inHours < 1) {
            return false; // Use cache if less than 1 hour old for other types
          }
      }
    }

    // If no cached data or stale cache, make the request
    return true;
  }
}
