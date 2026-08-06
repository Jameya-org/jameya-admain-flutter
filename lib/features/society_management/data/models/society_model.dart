class SocietyModel {
  final String id;
  final String code;
  final String name;
  final String status;
  final int currentTurn;
  final double monthlyAmount;
  final String startDate;
  final String endDate;
  final String duration;
  final String iconType;

  SocietyModel({
    required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.currentTurn,
    required this.monthlyAmount,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.iconType,
  });

  factory SocietyModel.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status'] ?? 'DRAFT';

    return SocietyModel(
      id: json['id']?.toString() ?? '',
      code: json['code'] ?? json['id']?.toString()?.substring(0, 8) ?? 'Unknown',
      name: json['name'] ?? 'جمعية',
      status: _mapStatusToArabic(rawStatus),
      currentTurn: json['currentTurn'] ?? json['currentMonth'] ?? 1,
      monthlyAmount: (json['monthlyAmount'] ?? json['installmentAmount'] ?? 0).toDouble(),
      startDate: json['startDate'] ?? json['createdAt'] ?? '',
      endDate: json['endDate'] ?? '',
      duration: json['durationMonths']?.toString() ?? '12',
      iconType: _mapStatusToIconType(rawStatus),
    );
  }

  /// Maps API status (English) to Arabic display label
  static String _mapStatusToArabic(String? status) {
    if (status == null) return 'مسودة';
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'IN_PROGRESS':
        return 'نشطة';
      case 'DRAFT':
      case 'PENDING':
      case 'UPCOMING':
        return 'مسودة';
      case 'COMPLETED':
      case 'FINISHED':
        return 'مكتملة';
      case 'CANCELLED':
      case 'EXPIRED':
      case 'ENDED':
        return 'منتهية';
      case 'LATE':
        return 'دفعات متأخرة';
      default:
        return 'مسودة';
    }
  }

  static String _mapStatusToIconType(String? status) {
    if (status == null) return 'waiting';
    switch (status.toUpperCase()) {
      case 'DRAFT':
      case 'UPCOMING':
      case 'PENDING':
        return 'waiting';
      case 'ACTIVE':
      case 'IN_PROGRESS':
        return 'active';
      case 'COMPLETED':
      case 'FINISHED':
        return 'completed';
      case 'CANCELLED':
      case 'EXPIRED':
      case 'ENDED':
      case 'LATE':
        return 'late';
      default:
        return 'waiting';
    }
  }
}
