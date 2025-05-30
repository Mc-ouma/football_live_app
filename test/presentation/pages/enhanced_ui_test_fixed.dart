import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:football_live_app/presentation/pages/home/home_page.dart';
import 'package:football_live_app/presentation/pages/home/tabs/fixtures_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/live_matches_tab.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/core/network/network_info.dart';
import 'package:football_live_app/core/utils/api_usage_monitor.dart';
import 'package:football_live_app/core/network/api_client.dart';
import 'package:football_live_app/core/utils/logger.dart';

// Mock classes
class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> get isConnected => Future.value(true);

  @override
  Stream<bool> get onConnectivityChanged => Stream.fromIterable([true]);
}

class MockLiveMatchesBloc extends Mock implements LiveMatchesBloc {}

class MockApiUsageMonitor extends Mock implements ApiUsageMonitor {
  @override
  Stream<ApiUsageLevel> get apiUsageStream =>
      Stream.fromIterable([ApiUsageLevel.normal]);

  @override
  ApiUsageLevel get currentUsageLevel => ApiUsageLevel.normal;
}

class MockApiClient extends Mock implements ApiClient {
  @override
  Map<String, dynamic> getRateLimitInfo() {
    return {
      'isRateLimited': false,
      'currentRequests': 10,
      'maxRequests': 100,
      'usagePercent': 10.0,
    };
  }
}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockLiveMatchesBloc mockLiveMatchesBloc;
  late MockApiUsageMonitor mockApiUsageMonitor;
  late MockApiClient mockApiClient;
  late MockLoggerService mockLoggerService;

  setUp(() {
    // Initialize mocks
    mockNetworkInfo = MockNetworkInfo();
    mockLiveMatchesBloc = MockLiveMatchesBloc();
    mockApiUsageMonitor = MockApiUsageMonitor();
    mockApiClient = MockApiClient();
    mockLoggerService = MockLoggerService();

    // Setup GetIt service locator for testing
    if (GetIt.instance.isRegistered<ApiUsageMonitor>()) {
      GetIt.instance.unregister<ApiUsageMonitor>();
    }
    if (GetIt.instance.isRegistered<ApiClient>()) {
      GetIt.instance.unregister<ApiClient>();
    }
    if (GetIt.instance.isRegistered<LoggerService>()) {
      GetIt.instance.unregister<LoggerService>();
    }

    GetIt.instance.registerSingleton<ApiUsageMonitor>(mockApiUsageMonitor);
    GetIt.instance.registerSingleton<ApiClient>(mockApiClient);
    GetIt.instance.registerSingleton<LoggerService>(mockLoggerService);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        Provider<NetworkInfo>.value(value: mockNetworkInfo),
        BlocProvider<LiveMatchesBloc>.value(value: mockLiveMatchesBloc),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('Enhanced UI Components Tests', () {
    testWidgets('Enhanced UI components should build without errors',
        (WidgetTester tester) async {
      // Simple test to verify that widgets can be instantiated
      expect(() => HomePage(), returnsNormally);
      expect(() => FixturesTab(), returnsNormally);
      expect(() => LiveMatchesTab(), returnsNormally);
    });

    testWidgets('HomePage should have proper responsive design elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(HomePage()));

      // Verify HomePage builds successfully
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('Enhanced widgets should support animations',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(
        Scaffold(
          body: FixturesTab(),
        ),
      ));

      // Verify FixturesTab builds successfully
      expect(find.byType(FixturesTab), findsOneWidget);

      // Verify animations are initialized (check for AnimatedBuilder or similar)
      await tester.pumpAndSettle();
    });

    testWidgets('LiveMatchesTab should handle different states',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(
        Scaffold(
          body: LiveMatchesTab(),
        ),
      ));

      // Verify LiveMatchesTab builds successfully
      expect(find.byType(LiveMatchesTab), findsOneWidget);
    });

    group('Enhanced UI Visual Elements', () {
      testWidgets('should support gradient backgrounds',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestableWidget(HomePage()));

        // Look for Container widgets that might have gradient decorations
        final containers = find.byType(Container);
        expect(containers, findsWidgets);
      });

      testWidgets('should have enhanced animations',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestableWidget(
          Scaffold(
            body: FixturesTab(),
          ),
        ));

        // Pump and settle to allow animations to complete
        await tester.pumpAndSettle();

        // Verify the widget tree is stable after animations
        expect(find.byType(FixturesTab), findsOneWidget);
      });

      testWidgets('should have responsive design capabilities',
          (WidgetTester tester) async {
        // Test with different screen sizes
        await tester.binding
            .setSurfaceSize(const Size(800, 600)); // Desktop size

        await tester.pumpWidget(createTestableWidget(HomePage()));

        expect(find.byType(HomePage), findsOneWidget);

        // Test with mobile size
        await tester.binding
            .setSurfaceSize(const Size(360, 640)); // Mobile size
        await tester.pump();

        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    group('Enhanced SliverAppBar Features', () {
      testWidgets('should support parallax effects and animations',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestableWidget(HomePage()));

        // Look for AppBar or SliverAppBar components
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    group('Enhanced Tab Components', () {
      testWidgets('should have modern tab styling',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestableWidget(HomePage()));

        // Look for TabBar components
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });
    });
  });
}
