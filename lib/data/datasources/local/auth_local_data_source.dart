import 'dart:convert';

import 'package:football_live_app/core/errors/exceptions.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  /// Get cached user
  Future<UserModel> getCachedUser();

  /// Cache user
  Future<void> cacheUser(UserModel user);

  /// Clear cached user
  Future<void> clearCachedUser();

  /// Get cached API key
  Future<ApiKeyModel?> getCachedApiKey();

  /// Cache API key
  Future<void> cacheApiKey(ApiKeyModel apiKey);

  /// Delete cached API key
  Future<void> deleteCachedApiKey();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final LoggerService logger;

  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.logger,
  });

  // Keys for SharedPreferences
  static const CACHED_USER = 'CACHED_USER';
  static const CACHED_API_KEY = 'CACHED_API_KEY';

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_USER);
      if (jsonString == null) {
        return UserModel.empty();
      }

      return UserModel.fromJson(json.decode(jsonString));
    } catch (e) {
      logger.error('Error getting cached user', error: e);
      throw CacheException(message: 'Failed to get cached user: $e');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        CACHED_USER,
        json.encode(user.toJson()),
      );
    } catch (e) {
      logger.error('Error caching user', error: e);
      throw CacheException(message: 'Failed to cache user: $e');
    }
  }

  @override
  Future<void> clearCachedUser() async {
    try {
      await sharedPreferences.remove(CACHED_USER);
    } catch (e) {
      logger.error('Error clearing cached user', error: e);
      throw CacheException(message: 'Failed to clear cached user: $e');
    }
  }

  @override
  Future<ApiKeyModel?> getCachedApiKey() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_API_KEY);
      if (jsonString == null) {
        return null;
      }

      return ApiKeyModel.fromJson(json.decode(jsonString));
    } catch (e) {
      logger.error('Error getting cached API key', error: e);
      throw CacheException(message: 'Failed to get cached API key: $e');
    }
  }

  @override
  Future<void> cacheApiKey(ApiKeyModel apiKey) async {
    try {
      await sharedPreferences.setString(
        CACHED_API_KEY,
        json.encode(apiKey.toJson()),
      );
    } catch (e) {
      logger.error('Error caching API key', error: e);
      throw CacheException(message: 'Failed to cache API key: $e');
    }
  }

  @override
  Future<void> deleteCachedApiKey() async {
    try {
      await sharedPreferences.remove(CACHED_API_KEY);
    } catch (e) {
      logger.error('Error deleting cached API key', error: e);
      throw CacheException(message: 'Failed to delete cached API key: $e');
    }
  }
}
