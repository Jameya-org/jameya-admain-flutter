/// Core business entity for creating a new ROSCA (Savings Circle / Jameya).
class CreateJameyaEntity {
  final int duration; // Duration in months (e.g. 6, 10, or 12)
  final double installmentAmount; // Monthly installment per member
  final double totalAmount; // Total payout per member = duration × installmentAmount
  final DateTime startDate; // Date of the first installment

  const CreateJameyaEntity({
    required this.duration,
    required this.installmentAmount,
    required this.totalAmount,
    required this.startDate,
  });
}
