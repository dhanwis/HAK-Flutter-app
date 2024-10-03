import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';

class UserIdProvider {
  static String? _userId;

  static Future<String?> initializeUserId() async {
    if (_userId == null) {
      try {
        final decodedToken =
            await decodeJwt(); // Use your existing decodeJwt method
        _userId =
            decodedToken['userId']; // Assuming userId is part of the token
        print('User ID initialized: $_userId');
      } catch (e) {
        print("Error decoding token: $e");
      }
    }
    return _userId;
  }

  static String? get userId => _userId; // Getter to access the userId
}
