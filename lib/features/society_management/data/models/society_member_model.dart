class SocietyMemberModel {
  final String id;
  final String name;
  final String phone;
  final String role;
  final String turn;
  final String status; // 'مدفوع' | 'معلق' | 'متأخر'
  final String avatar;

  SocietyMemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
    required this.turn,
    required this.status,
    required this.avatar,
  });
  factory SocietyMemberModel.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'] is Map<String, dynamic> ? json['customer'] : json;
    final rawStatus = json['status']?.toString() ?? 'CONFIRMED';
    final turnNumber = json['payoutPosition'] ?? json['turn'] ?? 1;

    return SocietyMemberModel(
      id: json['id']?.toString() ?? customer['id']?.toString() ?? '',
      name: customer['legalName'] ?? customer['name'] ?? customer['fullName'] ?? 'عضو جمعية',
      phone: customer['mobileNumber'] ?? customer['phone'] ?? '',
      role: json['role'] ?? 'عضو في الجمعية',
      turn: 'الدور $turnNumber',
      status: _mapStatusToArabic(rawStatus),
      avatar: customer['avatarUrl'] ?? customer['avatar'] ?? 'assets/images/profile.png',
    );
  }

  static String _mapStatusToArabic(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
      case 'PAID':
      case 'ACTIVE':
        return 'مدفوع';
      case 'PENDING':
      case 'PENDING_SIGNATURE':
      case 'UNDER_REVIEW':
        return 'معلق';
      case 'LATE':
      case 'DEFAULTED':
      case 'OVERDUE':
        return 'متأخر';
      default:
        return 'مدفوع';
    }
  }
}
