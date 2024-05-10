class OtpModel {
  String? refresh;
  String? access;
  String? otp;
  String? message;

  OtpModel({this.refresh, this.access, this.otp, this.message});

  OtpModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    otp = json['otp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['otp'] = this.otp;
    data['message'] = this.message;
    return data;
  }
}