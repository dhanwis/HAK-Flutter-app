import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner;
  final TokenStorage _tokenStorage = TokenStorage();

  AuthHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Check if token is close to expiration and refresh if necessary
    final shouldRefresh = await _shouldRefreshToken();
    if (shouldRefresh) {
      await _refreshToken();
    }

    // Get the updated access token
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    final response = await _inner.send(request);

    if (response.statusCode == 401) {
      // Retry on token expiration
      bool refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with the new token
        final newAccessToken = await _tokenStorage.getAccessToken();
        request.headers['Authorization'] = 'Bearer $newAccessToken';
        return _inner.send(request);
      }
    }
    return response;
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    final response = await http.post(
      Uri.parse('${AppConstants.BASE_URL}/auth_customer/auth/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final newAccessToken = responseData['accessToken'];
      final newRefreshToken = responseData['refreshToken'];

      await _tokenStorage.saveTokens(newAccessToken, newRefreshToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _shouldRefreshToken() async {
    final expiryTime = await _tokenStorage.getAccessTokenExpiry();
    if (expiryTime == null) return false;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final refreshThreshold = 120000; // Refresh 2 minutes before expiration

    return expiryTime - currentTime <= refreshThreshold;
  }
}
