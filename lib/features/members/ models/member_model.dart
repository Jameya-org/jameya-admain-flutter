class MemberModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String kycStatus;
  final String createdAt;

  const MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.kycStatus,
    required this.createdAt,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] ?? '',
      name: json['legalName'] ?? '',
      email: json['email'] ?? '',
      phone: json['mobileNumber'] ?? '',
      status: json['status'] ?? '',
      kycStatus: json['identityProfile']?['kycStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}