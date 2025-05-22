import 'package:logger/logger.dart';

/// A simple logging class providing static access to logging functionality
class AppLogger {
  static late final LoggerService _instance;
  static bool _initialized = false;

  /// Initialize the logger
  static void init() {
    if (_initialized) return;
    _instance = LoggerService();
    _initialized = true;
  }

  /// Log a debug message
  static void d(String message, {Object? error, StackTrace? stackTrace}) {
    if (_initialized) {
      _instance.debug(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an info message
  static void i(String message, {Object? error, StackTrace? stackTrace}) {
    if (_initialized) {
      _instance.info(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log a warning message
  static void w(String message, {Object? error, StackTrace? stackTrace}) {
    if (_initialized) {
      _instance.warning(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an error message
  static void e(String message, {Object? error, StackTrace? stackTrace}) {
    if (_initialized) {
      _instance.error(message, error: error, stackTrace: stackTrace);
    }
  }
}

class LoggerService {
  late final Logger _logger;

  LoggerService() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTime,
      ),
    );
  }

  void debug(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void warning(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void error(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void verbose(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
