import 'package:jameya/features/create_jameya/domain/entities/create_jameya_entity.dart';

/// Serializable request body for `POST /admin/circles`.
///
/// Field mapping (API ↔ domain):
///   amount             ← entity.totalAmount
///   contributionAmount ← entity.installmentAmount
///   durationMonths     ← entity.duration
///   memberCapacity     ← entity.duration  (one member collects per cycle in ROSCA)
///   cycleFrequency     ← "MONTHLY"        (only frequency supported)
///   startDate          ← entity.startDate (ISO-8601)
class CreateJameyaRequestModel {
  final double amount;
  final double contributionAmount;
  final int durationMonths;
  final int memberCapacity;
  final String cycleFrequency;
  final String startDate;

  const CreateJameyaRequestModel({
    required this.amount,
    required this.contributionAmount,
    required this.durationMonths,
    required this.memberCapacity,
    required this.cycleFrequency,
    required this.startDate,
  });

  factory CreateJameyaRequestModel.fromEntity(CreateJameyaEntity entity) {
    return CreateJameyaRequestModel(
      amount: entity.totalAmount,
      contributionAmount: entity.installmentAmount,
      durationMonths: entity.duration,
      memberCapacity: entity.duration, // In a ROSCA, members = months
      cycleFrequency: 'MONTHLY',
      startDate: entity.startDate.toUtc().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'contributionAmount': contributionAmount,
        'durationMonths': durationMonths,
        'memberCapacity': memberCapacity,
        'cycleFrequency': cycleFrequency,
        'startDate': startDate,
      };
}
