class Address {
  final String name;
  final String phone;
  final String street;
  final String city;
  final String pinCode;
  //final Bool isDefault;

  Address({
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.pinCode,
    // required this.isDefault,
  });

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'pinCode': pinCode,
    };
  }

  // Create Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      phone: json['phone'],
      street: json['street'],
      city: json['city'],
      pinCode: json['pinCode'],
      //isDefault: json['isDefault'],
    );
  }
}
