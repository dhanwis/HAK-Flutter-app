import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<Map<String, dynamic>> decodeJwt() async {
  final TokenStorage tokenStorage = TokenStorage();

  // Fetch the access token asynchronously
  final accessToken = await tokenStorage.getAccessToken();

  print('acces now');
  print(accessToken);

  // Check if accessToken is null or invalid
  if (accessToken == null || accessToken.isEmpty) {
    throw Exception("Access token not found");
  }

  // Decode the token, JwtDecoder.decode returns a Map<String, dynamic>
  Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

  print('access return now');
  print(decodedToken);

  return decodedToken;
}
