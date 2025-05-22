// filepath: /home/luizzy/Flutter Projects/football_live_app/lib/data/datasources/remote/auth_remote_data_source_factory.dart
import 'package:football_live_app/core/config/firebase_config.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:football_live_app/data/datasources/remote/auth_remote_data_source_stub_impl.dart';

/// Factory to get the appropriate auth implementation based on platform
class AuthRemoteDataSourceFactory {
  /// Creates the appropriate implementation based on Firebase availability
  static AuthRemoteDataSource create(LoggerService logger) {
    if (FirebaseConfig.hasAuthSupport()) {
      return AuthRemoteDataSourceImpl(logger: logger);
    } else {
      return AuthRemoteDataSourceStubImpl(logger: logger);
    }
  }
}
