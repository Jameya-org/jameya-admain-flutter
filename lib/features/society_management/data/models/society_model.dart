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
}
