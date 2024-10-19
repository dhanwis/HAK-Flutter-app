class CustomerProfile {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String pincode;
  final String city;
  final String state;
  final String? userImg; // Nullable field for user image
  final List<Map<String, dynamic>>?
      addresses; // Assuming addresses are stored as maps

  CustomerProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.pincode,
    required this.city,
    required this.state,
    this.userImg,
    this.addresses,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['_id'] ?? "", // Provide default value if null
      username: json['username'] ?? "", // Use empty string if null
      email: json['email'] ?? "", // Use empty string if null
      phoneNumber: json['phoneNumber'] ?? "", // Use empty string if null
      pincode: json['pincode'] ?? "", // Use empty string if null
      city: json['city'] ?? "", // Use empty string if null
      state: json['state'] ?? "", // Use empty string if null
      userImg: json['userImg'], // Nullable, so no need to provide default value
      addresses: List<Map<String, dynamic>>.from(json['addresses']),
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
