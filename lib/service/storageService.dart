import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rp_limpezas_front/enum/storageKeysEnum.dart';

/// A service to handle JWT token storage using Flutter Secure Storage.
/// This service provides methods to save, retrieve, and delete JWT tokens securely.
class StorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static final String _refreshTokenKey = 'refresh';

  /// Saves the JWT token securely.
  /// [token] is the JWT token to be saved.
  /// Returns a Future that completes when the token is saved.
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: StorageKeysEnum.accessToken.key, value: token);
  }

  /// Retrieves the JWT token securely.
  /// Returns a Future that completes with the JWT token if it exists, or null if it
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: StorageKeysEnum.accessToken.key);
  }

  /// Saves the JWT refresh token securely.
  /// [token] is the JWT token to be saved.
  /// Returns a Future that completes when the token is saved.
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: StorageKeysEnum.refreshToken.key, value: token);
  }

  /// Retrieves the JWT refresh token securely.
  /// Returns a Future that completes with the JWT token if it exists, or null if it
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: StorageKeysEnum.refreshToken.key);
  }

  /// Deletes the JWT token securely.
  /// Returns a Future that completes when the token is deleted.
  static Future<void> deleteTokens() async {
    await _storage.delete(key: StorageKeysEnum.accessToken.key);
    await _storage.delete(key: StorageKeysEnum.refreshToken.key);
  }

  /// Gets a generic value from secure storage.
  /// [key] is the key for the value to be retrieved.
  static Future<String?> getGenericValue(String key) async {
    return await _storage.read(key: key);
  }

  /// Saves a generic value securely.
  /// [key] is the key for the value to be saved. 
  static void setGenericValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}