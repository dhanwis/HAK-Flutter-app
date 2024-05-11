class AuthResponse {
  String? refresh;
  String? access;
  String? otp;
  String? message;

  AuthResponse({this.refresh, this.access, this.otp, this.message});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    otp = json['otp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['refresh'] = refresh;
    data['access'] = access;
    data['otp'] = otp;
    data['message'] = message;
    return data;
  }
}