/// Model for expenses / transactions (/admin/transactions)
class ExpenseModel {
  final String id;
  final String memberName;
  final String phone;
  final String floor; // الدور
  final double amount;
  final String date; // ISO date string for grouping
  final bool isConfirmed;

  ExpenseModel({
    required this.id,
    required this.memberName,
    required this.phone,
    required this.floor,
    required this.amount,
    required this.date,
    required this.isConfirmed,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    final rawName = json['customerName'] ??
        json['memberName'] ??
        json['member']?['name'] ??
        json['customer']?['name'] ??
        json['customer']?['legalName'] ??
        'عضو';

    return ExpenseModel(
      id: json['id']?.toString() ?? '',
      memberName: _toArabicName(rawName),
      phone: json['mobileNumber'] ??
          json['customerMobile'] ??
          json['phone'] ??
          json['member']?['phone'] ??
          json['customer']?['phone'] ??
          '01234567890',
      floor: _formatFloor(json['payoutPosition'], json['cycleNumber'], json['floor']),
      amount: _parseAmount(json['amount'] ?? json['installmentAmount']),
      date: _formatDate(json['timestamp'] ?? json['date'] ?? json['createdAt'] ?? json['paidAt']),
      isConfirmed: json['isConfirmed'] == true ||
          json['status']?.toString().toUpperCase() == 'CONFIRMED' ||
          json['status']?.toString().toUpperCase() == 'SETTLED',
    );
  }

  static String _toArabicName(dynamic val) {
    if (val == null) return 'احمد علي سامح';
    final name = val.toString().trim();
    if (name.isEmpty) return 'احمد علي سامح';

    const translations = {
      'ahmed mahmoud hassan': 'أحمد محمود حسن',
      'mona ali sayed': 'منى علي سيد',
      'fatma zaki': 'فاطمة زكي',
      'ahmed ali sameh': 'احمد علي سامح',
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
    return 'الدور الرابع';
  }

  static String _formatDate(dynamic rawDate) {
    if (rawDate == null) return 'اليوم';
    final str = rawDate.toString();
    try {
      final dt = DateTime.parse(str);
      final now = DateTime.now();
      if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
        return 'اليوم';
      }
      return '${dt.day}-${dt.month}-${dt.year}';
    } catch (_) {
      return str;
    }
  }
}

/// Summary header model for expenses screen
class ExpensesSummaryModel {
  final int operationsCount;
  final double totalAmount;

  const ExpensesSummaryModel({
    required this.operationsCount,
    required this.totalAmount,
  });
}
