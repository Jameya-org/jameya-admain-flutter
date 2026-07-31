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
}
