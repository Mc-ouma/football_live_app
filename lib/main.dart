// filepath: /home/luizzy/Flutter Projects/football_live_app/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/config/firebase_config.dart';
import 'package:football_live_app/core/di/injection.dart' as di;
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_data_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger first
  AppLogger.init();

  // Setup environment configuration
  EnvConfig.initialize();

  // Initialize Firebase with platform-aware configuration
  await FirebaseConfig.initialize();

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NetworkInfo>(
          create: (_) => di.sl<NetworkInfo>(),
        ),
        // Conditionally include AuthBloc only if Firebase Auth is available
        if (FirebaseConfig.hasAuthSupport())
          BlocProvider<AuthBloc>(
            create: (_) => di.sl<AuthBloc>(),
          ),
        BlocProvider<LiveMatchesBloc>(
          create: (_) => di.sl<LiveMatchesBloc>(),
        ),
        BlocProvider<StandingsBloc>(
          create: (_) => di.sl<StandingsBloc>(),
        ),
        BlocProvider<PredictionBloc>(
          create: (_) => di.sl<PredictionBloc>(),
        ),
        BlocProvider<PredictionDataBloc>(
          create: (_) => di.sl<PredictionDataBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Football Live',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
