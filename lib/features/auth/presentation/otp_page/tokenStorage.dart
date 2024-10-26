import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = FlutterSecureStorage();

  // Save tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  // Read access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  // Read refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  // Delete tokens
  Future<void> deleteTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }

  Future<int?> getAccessTokenExpiry() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) return null;

    // Decode and extract expiration time from the JWT (if applicable)
    final payload = accessToken.split('.')[1];
    final decoded = utf8.decode(base64Url.decode(base64Url.normalize(payload)));
    final exp = jsonDecode(decoded)['exp'];

    return exp != null ? exp * 1000 : null; // Convert to milliseconds
  }
}
