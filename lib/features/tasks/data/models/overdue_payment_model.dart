/// Model for a single overdue payment entry (/admin/installments?status=OVERDUE)
class OverduePaymentModel {
  final String id;
  final String memberName;
  final String email;
  final String phone;
  final String floor; // الدور
  final String dueDate; // تاريخ الاستحقاق
  final double amount;
  final int daysLate;
  final String? avatarUrl;

  OverduePaymentModel({
    required this.id,
    required this.memberName,
    required this.email,
    required this.phone,
    required this.floor,
    required this.dueDate,
    required this.amount,
    required this.daysLate,
    this.avatarUrl,
  });

  factory OverduePaymentModel.fromJson(Map<String, dynamic> json) {
    final rawName = json['customerName'] ??
        json['memberName'] ??
        json['member']?['name'] ??
        json['customer']?['name'] ??
        json['customer']?['legalName'] ??
        'عضو';

    return OverduePaymentModel(
      id: json['id']?.toString() ?? json['installmentId']?.toString() ?? '',
      memberName: _toArabicName(rawName),
      email: json['customerEmail'] ??
          json['email'] ??
          json['member']?['email'] ??
          json['customer']?['email'] ??
          'ex@gmail.com',
      phone: json['mobileNumber'] ??
          json['customerMobile'] ??
          json['phone'] ??
          json['member']?['phone'] ??
          json['customer']?['phone'] ??
          '01234567890',
      floor: _formatFloor(json['payoutPosition'], json['cycleNumber'], json['floor']),
      dueDate: _formatDate(json['dueDate'] ?? json['due_date']),
      amount: _parseAmount(json['amount'] ?? json['installmentAmount']),
      daysLate: _parseInt(json['daysLate'] ?? json['days_late']),
      avatarUrl: json['avatarUrl'] ??
          json['avatar'] ??
          json['customer']?['avatarUrl'] ??
          json['profileImage'] ??
          'https://i.pravatar.cc/150?img=60',
    );
  }

  static String _toArabicName(dynamic val) {
    if (val == null) return 'محمد احمد علي';
    final name = val.toString().trim();
    if (name.isEmpty) return 'محمد احمد علي';

    const translations = {
      'ahmed mahmoud hassan': 'أحمد محمود حسن',
      'mona ali sayed': 'منى علي سيد',
      'fatma zaki': 'فاطمة زكي',
      'ahmed ali sameh': 'احمد علي سامح',
      'mohamed ahmed ali': 'محمد احمد علي',
    };

    final lower = name.toLowerCase();
    if (translations.containsKey(lower)) {
      return translations[lower]!;
    }
    return name;
  }

  static double _parseAmount(dynamic val) {
    if (val == null) return 0.0;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 3;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? 3;
    return 3;
  }

  static String _formatFloor(dynamic pos, dynamic cycle, String? rawFloor) {
    if (rawFloor != null && rawFloor.isNotEmpty) return rawFloor;
    final numVal = pos ?? cycle;
    if (numVal != null) {
      final n = int.tryParse(numVal.toString());
      if (n != null) {
        const arabicNumbers = [
          'الأول', 'الثاني', 'الثالث', 'الرابع', 'الخامس',
          'السادس', 'السابع', 'الثامن', 'التاسع', 'العاشر'
        ];
        if (n >= 1 && n <= arabicNumbers.length) {
          return 'الدور ${arabicNumbers[n - 1]}';
        }
        return 'الدور $n';
      }
    }
    return 'الدور السابع';
  }

  static String _formatDate(dynamic rawDate) {
    if (rawDate == null) return '1-7-2026';
    final str = rawDate.toString();
    try {
      final dt = DateTime.parse(str);
      return '${dt.day}-${dt.month}-${dt.year}';
    } catch (_) {
      return str;
    }
  }
}
