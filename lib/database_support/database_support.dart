import 'package:shared_preferences/shared_preferences.dart';

class DatabaseSupport {
  static saveusername(
    String mobilenumber,
  ) async {
    final db = await SharedPreferences.getInstance();
    await db.setString('mobilenumber', mobilenumber);
  }
}
