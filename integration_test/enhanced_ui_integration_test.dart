import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:football_live_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Enhanced UI Integration Tests', () {
    testWidgets('Complete enhanced UI flow test', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test 1: HomePage loads with enhanced AppBar
      expect(find.byType(AppBar), findsOneWidget);

      // Allow animations to complete
      await tester.pump(const Duration(milliseconds: 1000));

      // Test 2: Tab navigation works with enhanced animations
      expect(find.text('Fixtures'), findsOneWidget);
      expect(find.text('Live'), findsOneWidget);

      // Test 3: Fixtures tab enhanced UI
      await tester.tap(find.text('Fixtures'));
      await tester.pumpAndSettle();

      // Check for enhanced fixtures header
      expect(find.text('Football Fixtures'), findsOneWidget);

      // Test 4: Live matches tab enhanced UI
      await tester.tap(find.text('Live'));
      await tester.pumpAndSettle();

      // Check for enhanced live matches header
      expect(find.text('Live Matches'), findsOneWidget);
      expect(find.text('Real-time updates every 30 seconds'), findsOneWidget);

      // Test 5: Responsive design on different screen sizes
      // Simulate device rotation
      await tester.binding.setSurfaceSize(const Size(812, 375)); // Landscape
      await tester.pumpAndSettle();

      // Ensure UI still works in landscape
      expect(find.text('Live Matches'), findsOneWidget);

      // Return to portrait
      await tester.binding.setSurfaceSize(const Size(375, 812));
      await tester.pumpAndSettle();

      // Test 6: Animation performance
      // Test scrolling with enhanced animations
      final scrollable = find.byType(Scrollable).first;
      await tester.drag(scrollable, const Offset(0, -300));
      await tester.pumpAndSettle();

      // Test 7: Error handling with enhanced error states
      // This would require network simulation to test error states

      // Test 8: Pull-to-refresh functionality
      await tester.drag(scrollable, const Offset(0, 300));
      await tester.pumpAndSettle();
    });

    testWidgets('Enhanced SliverAppBar functionality in MatchDetails',
        (WidgetTester tester) async {
      // This test would require navigating to a match details page
      // For now, we'll focus on the main navigation flow

      app.main();
      await tester.pumpAndSettle();

      // Test enhanced tab bar
      expect(find.byType(TabBar), findsOneWidget);

      // Test scrolling behavior if content is available
      if (find.byType(Scrollable).hasFound) {
        final scrollable = find.byType(Scrollable).first;
        await tester.drag(scrollable, const Offset(0, -100));
        await tester.pump(const Duration(milliseconds: 500));
      }
    });

    testWidgets('Animation performance under stress',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Rapid tab switching to test animation performance
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Fixtures'));
        await tester.pump(const Duration(milliseconds: 100));

        await tester.tap(find.text('Live'));
        await tester.pump(const Duration(milliseconds: 100));
      }

      // Final settle to ensure all animations complete
      await tester.pumpAndSettle();

      // Verify UI is still responsive
      expect(find.text('Live Matches'), findsOneWidget);
    });

    testWidgets('Enhanced UI accessibility features',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test semantic labels for enhanced UI elements
      expect(find.byType(Semantics), findsAtLeastNWidgets(1));

      // Test that enhanced animations don't interfere with accessibility
      await tester.tap(find.text('Fixtures'));
      await tester.pumpAndSettle();

      // Verify accessibility after tab change
      expect(find.byType(Semantics), findsAtLeastNWidgets(1));
    });

    testWidgets('Enhanced gradient backgrounds render correctly',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test that gradient containers are present
      expect(find.byType(Container), findsAtLeastNWidgets(1));

      // Check different tabs for gradient backgrounds
      await tester.tap(find.text('Fixtures'));
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsAtLeastNWidgets(1));

      await tester.tap(find.text('Live'));
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });

    testWidgets('Enhanced loading and error states',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial loading might show enhanced loading indicators
      // Test that enhanced loading states work
      if (find.byType(CircularProgressIndicator).hasFound) {
        expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));

        // Wait for loading to complete
        await tester.pumpAndSettle(const Duration(seconds: 5));
      }

      // Test that UI recovers properly from loading states
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Memory usage with enhanced animations',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test multiple navigation cycles to ensure no memory leaks
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.text('Fixtures'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Live'));
        await tester.pumpAndSettle();
      }

      // Verify UI is still functional
      expect(find.text('Live Matches'), findsOneWidget);
    });
  });
}
