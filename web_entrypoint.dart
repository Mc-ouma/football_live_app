import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:football_live_app/main.dart' as app;

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Use path-based URL strategy for better web URLs (removes # from URLs)
  usePathUrlStrategy();

  // Call the main app entry point
  app.main();
}
