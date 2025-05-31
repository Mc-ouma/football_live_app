import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/fixture_details_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/standings_bloc.dart';
import 'package:football_live_app/presentation/pages/home/home_page.dart';
import 'package:football_live_app/presentation/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration before dependency injection
  EnvConfig.initialize();

  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap the entire app with MultiProvider at the root level
    return MultiProvider(
      providers: [
        // Provide NetworkInfo at the top level so it's available throughout the app
        Provider<NetworkInfo>(create: (_) => getIt<NetworkInfo>()),
        // BLoCs - provide them at the root level so they're available everywhere
        BlocProvider<LiveMatchesBloc>(create: (_) => getIt<LiveMatchesBloc>()),
        BlocProvider<PredictionBloc>(create: (_) => getIt<PredictionBloc>()),
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        // Add missing BLoCs that are referenced in the app
        BlocProvider<FixtureDetailsBloc>(
            create: (_) => getIt<FixtureDetailsBloc>()),
        BlocProvider<StandingsBloc>(create: (_) => getIt<StandingsBloc>()),
      ],
      child: MaterialApp(
        title: 'Football Live App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
        routes: {
          // Use builder pattern to ensure BLoCs are properly passed to routes
          '/home': (context) => const HomePage(),
        },
        onGenerateRoute: (settings) {
          // Handle dynamic routes here if needed in the future
          return null;
        },
      ),
    );
  }
}
