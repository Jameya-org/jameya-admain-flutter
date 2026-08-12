class MembershipModel {
  final String id;
  final String customerId;
  final String status;
  final int payoutPosition;
  final Circle circle;

  MembershipModel({
    required this.id,
    required this.customerId,
    required this.status,
    required this.payoutPosition,
    required this.circle,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id']?.toString() ?? '',

      customerId: json['customerId']?.toString() ?? '',

      status: json['status']?.toString() ?? '',

      payoutPosition: int.tryParse(
        json['payoutPosition']?.toString() ?? '',
      ) ??
          0,

      circle: Circle.fromJson(
        json['circle'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}



  class Circle {
  final String id;
  final double amount;
  final double contributionAmount;
  final int durationMonths;
  final String status;

  Circle({
  required this.id,
  required this.amount,
  required this.contributionAmount,
  required this.durationMonths,
  required this.status,
  });

  factory Circle.fromJson(Map<String, dynamic> json) {
  return Circle(
  id: json['id']?.toString() ?? '',

  amount: double.tryParse(json['amount']?.toString() ?? '') ?? 0,

  contributionAmount: double.tryParse(
  json['contributionAmount']?.toString() ?? '',
  ) ??
  0,

  durationMonths:int.tryParse(json['durationMonths']?.toString() ?? '') ?? 0,

  status: json['status']?.toString() ?? '',
  );
  }
  }