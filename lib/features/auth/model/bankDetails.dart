class BankDetail {
  String? id;
  String? userId;
  String accountNumber;
  String bankName;
  String ifscCode;
  String accountHolderName;

  BankDetail({
    this.id,
    this.userId,
    required this.accountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.accountHolderName,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) {
    return BankDetail(
      id: json['_id'],
      userId: json['userId'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      ifscCode: json['ifscCode'],
      accountHolderName: json['accountHolderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'bankName': bankName,
      'ifscCode': ifscCode,
      'accountHolderName': accountHolderName,
    };
  }
}
