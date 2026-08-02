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
    // Basic mapping from typical API circle structure to UI model
    final status = json['status'] ?? 'DRAFT';
    
    return SocietyModel(
      id: json['id']?.toString() ?? '',
      code: json['code'] ?? json['id']?.toString()?.substring(0, 8) ?? 'Unknown',
      name: json['name'] ?? 'جمعية',
      status: status,
      currentTurn: json['currentTurn'] ?? json['currentMonth'] ?? 1,
      monthlyAmount: (json['monthlyAmount'] ?? json['installmentAmount'] ?? 0).toDouble(),
      startDate: json['startDate'] ?? json['createdAt'] ?? '',
      endDate: json['endDate'] ?? '',
      duration: json['durationMonths']?.toString() ?? '12',
      iconType: _mapStatusToIconType(status),
    );
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
        return 'completed';
      case 'CANCELLED':
      case 'LATE':
        return 'late';
      default:
        return 'waiting';
    }
  }
}
