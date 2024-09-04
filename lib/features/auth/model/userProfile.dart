// lib/models/customer_profile_model.dart
class CustomerProfile {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String pincode;
  final String city;
  final String? state;
  final String? userImg;

  CustomerProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.pincode,
    required this.city,
    this.state, // Nullable field
    this.userImg,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      pincode: json['pincode'],
      city: json['city'],
      state: json['state'],
      userImg: json['userImg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'pincode': pincode,
      'city': city,
      'state': state,
      'userImg': userImg,
    };
  }
}
