class SocietyPaymentModel {
  final String id;
  final String monthName;
  final String dueDate;
  final double amount;
  final String status; // 'مدفوع' | 'معلق' | 'قادم'
  final int paidCount;
  final int pendingCount;
  final int lateCount;

  SocietyPaymentModel({
    required this.id,
    required this.monthName,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.paidCount,
    required this.pendingCount,
    required this.lateCount,
  });
  factory SocietyPaymentModel.fromJson(Map<String, dynamic> json) {
    final rawDate = json['dueDate']?.toString() ?? json['monthName']?.toString() ?? '';
    String formattedDate = rawDate;
    if (rawDate.length >= 10 && rawDate.contains('T')) {
      formattedDate = rawDate.substring(0, 10);
    }

    final rawStatus = json['status']?.toString() ?? 'PAID';

    return SocietyPaymentModel(
      id: json['id']?.toString() ?? '',
      monthName: json['monthName'] ?? formattedDate,
      dueDate: formattedDate,
      amount: (json['amount'] ?? json['installmentAmount'] ?? 0).toDouble(),
      status: _mapStatusToArabic(rawStatus),
      paidCount: json['paidCount'] ?? 0,
      pendingCount: json['pendingCount'] ?? 0,
      lateCount: json['lateCount'] ?? 0,
    );
  }

  static String _mapStatusToArabic(String status) {
    switch (status.toUpperCase()) {
      case 'PAID':
      case 'SETTLED':
      case 'COMPLETED':
        return 'مدفوع';
      case 'PENDING':
      case 'PENDING_VERIFICATION':
      case 'PROCESSING':
        return 'معلق';
      case 'UPCOMING':
      case 'FUTURE':
      case 'DRAFT':
        return 'قادم';
      default:
        return 'قادم';
    }
  }
}
