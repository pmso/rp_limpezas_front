import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A service to handle JWT token storage using Flutter Secure Storage.
/// This service provides methods to save, retrieve, and delete JWT tokens securely.
class TokenService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static final String _accessTokenKey = 'jwt';
  static final String _refreshTokenKey = 'refresh';

  /// Saves the JWT token securely.
  /// [token] is the JWT token to be saved.
  /// Returns a Future that completes when the token is saved.
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Retrieves the JWT token securely.
  /// Returns a Future that completes with the JWT token if it exists, or null if it
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Saves the JWT refresh token securely.
  /// [token] is the JWT token to be saved.
  /// Returns a Future that completes when the token is saved.
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Retrieves the JWT refresh token securely.
  /// Returns a Future that completes with the JWT token if it exists, or null if it
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Deletes the JWT token securely.
  /// Returns a Future that completes when the token is deleted.
  static Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
  }
}