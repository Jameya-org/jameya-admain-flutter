class PaymentModel {
  final String title;
  final String amount;
  final String dueDate;
  final String status;
  final String method;

  const PaymentModel({
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.method,
  });
}