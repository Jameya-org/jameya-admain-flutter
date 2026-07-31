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
}
