import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/config/firebase_config.dart';
import 'package:football_live_app/core/di/injection.dart' as di;
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        // Conditionally include AuthBloc only if Firebase Auth is available
        if (FirebaseConfig.hasAuthSupport())
          BlocProvider(
              create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatusEvent())),
        BlocProvider(create: (_) => di.sl<LiveMatchesBloc>()),
        BlocProvider(create: (_) => di.sl<StandingsBloc>()),
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
