import 'package:hive/hive.dart';
//  part 'otp_page.dart';

@HiveType(typeId: 1)
class Token extends HiveObject {
  @HiveField(0)
  late String accessToken;

  @HiveField(1)
  late String refreshToken;

  Token(this.accessToken, this.refreshToken);
}
