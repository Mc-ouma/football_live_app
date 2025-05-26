import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/config/env_config.dart';
import 'package:football_live_app/core/di/injection.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/home/home_page.dart';
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
    return MultiProvider(
      providers: [
        // Provide NetworkInfo at the top level
        Provider<NetworkInfo>(create: (_) => getIt<NetworkInfo>()),
      ],
      child: MaterialApp(
        title: 'Football Live App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<LiveMatchesBloc>()),
            BlocProvider(create: (_) => getIt<PredictionBloc>()),
            BlocProvider(create: (_) => getIt<AuthBloc>()),
          ],
          child: HomePage(),
        ),
        routes: {
          '/home': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => getIt<LiveMatchesBloc>()),
                  BlocProvider(create: (_) => getIt<PredictionBloc>()),
                  BlocProvider(create: (_) => getIt<AuthBloc>()),
                ],
                child: HomePage(),
              ),
        },
      ),
    );
  }
}
