import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/local/app_database.dart';
import 'package:football_live_app/data/datasources/local/auth_local_data_source.dart';
import 'package:football_live_app/data/datasources/local/football_local_data_source.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source.dart';
// Use the factory method for creating the appropriate auth implementation
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source_factory.dart';
import 'package:football_live_app/data/datasources/remote/football_remote_data_source.dart';
import 'package:football_live_app/data/repositories/auth_repository_impl.dart';
import 'package:football_live_app/data/repositories/football_repository_impl.dart';
import 'package:football_live_app/domain/repositories/auth_repository.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:football_live_app/domain/usecases/auth/get_current_user.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_email.dart';
import 'package:football_live_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:football_live_app/domain/usecases/auth/sign_out.dart';
import 'package:football_live_app/domain/usecases/football/get_league_standings.dart';
import 'package:football_live_app/domain/usecases/football/get_live_matches.dart';
import 'package:football_live_app/domain/usecases/football/get_player_statistics.dart';
import 'package:football_live_app/domain/usecases/football/get_team_information.dart';
import 'package:football_live_app/domain/usecases/football/get_upcoming_fixtures.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/player_stats_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/team_info_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/upcoming_fixtures_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => LoggerService());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
  );

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      dio: sl<Dio>(),
      connectivity: sl<Connectivity>(),
      logger: sl<LoggerService>(),
    ),
  );

  // Database
  sl.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );

  // Data Sources
  sl.registerLazySingleton<FootballRemoteDataSource>(
    () => FootballRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerLazySingleton<FootballLocalDataSource>(
    () => FootballLocalDataSourceImpl(
      database: sl<AppDatabase>(),
      sharedPreferences: sl<SharedPreferences>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceFactory.create(sl<LoggerService>()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
      logger: sl<LoggerService>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<FootballRepository>(
    () => FootballRepositoryImpl(
      remoteDataSource: sl<FootballRemoteDataSource>(),
      localDataSource: sl<FootballLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      logger: sl<LoggerService>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetLiveMatches(sl<FootballRepository>()));
  sl.registerLazySingleton(() => GetUpcomingFixtures(sl<FootballRepository>()));
  sl.registerLazySingleton(() => GetLeagueStandings(sl<FootballRepository>()));
  sl.registerLazySingleton(() => GetTeamInformation(sl<FootballRepository>()));
  sl.registerLazySingleton(() => GetPlayerStatistics(sl<FootballRepository>()));

  sl.registerLazySingleton(() => SignInWithEmail(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOut(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUser(sl<AuthRepository>()));

  // BLoCs
  sl.registerFactory(
    () => LiveMatchesBloc(
      getLiveMatches: sl<GetLiveMatches>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerFactory(
    () => StandingsBloc(
      getLeagueStandings: sl<GetLeagueStandings>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerFactory(
    () => UpcomingFixturesBloc(
      getUpcomingFixtures: sl<GetUpcomingFixtures>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerFactory(
    () => TeamInfoBloc(
      getTeamInformation: sl<GetTeamInformation>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerFactory(
    () => PlayerStatsBloc(
      getPlayerStatistics: sl<GetPlayerStatistics>(),
      logger: sl<LoggerService>(),
    ),
  );

  sl.registerFactory(
    () => AuthBloc(
      signInWithEmail: sl<SignInWithEmail>(),
      signInWithGoogle: sl<SignInWithGoogle>(),
      signOut: sl<SignOut>(),
      getCurrentUser: sl<GetCurrentUser>(),
      logger: sl<LoggerService>(),
    ),
  );
}
