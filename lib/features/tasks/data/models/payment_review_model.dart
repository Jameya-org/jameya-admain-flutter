/// Model for payment review (/admin/payment-proofs & /admin/transactions)
class PaymentReviewModel {
  final String id;
  final String memberName;
  final String phone;
  final String floor; // الدور
  final String timeAgo; // منذ X دقيقة
  final double amount;
  final String status; // 'success' | 'failed'

  PaymentReviewModel({
    required this.id,
    required this.memberName,
    required this.phone,
    required this.floor,
    required this.timeAgo,
    required this.amount,
    required this.status,
  });

  bool get isSuccess => status == 'success' || status == 'APPROVED';

  factory PaymentReviewModel.fromJson(Map<String, dynamic> json) {
    final transaction = json['transaction'] is Map<String, dynamic>
        ? json['transaction'] as Map<String, dynamic>
        : null;

    final customer = transaction?['installment']?['membership']?['customer'] is Map<String, dynamic>
        ? transaction!['installment']['membership']['customer'] as Map<String, dynamic>
        : null;

    final rawName = customer?['legalName'] ??
        json['customerName'] ??
        json['memberName'] ??
        transaction?['customerName'] ??
        json['member']?['name'] ??
        'عضو';

    final rawStatus = json['reviewStatus'] ??
        json['status'] ??
        transaction?['status'] ??
        'PENDING';

    final cycleNum = transaction?['installment']?['cycleNumber'] ??
        json['payoutPosition'] ??
        json['cycleNumber'];

    final rawAmount = json['claimedAmount'] ??
        json['amount'] ??
        transaction?['amount'];

    return PaymentReviewModel(
      id: json['id']?.toString() ?? '',
      memberName: _toArabicName(rawName),
      phone: customer?['mobileNumber'] ??
          json['senderMobileOrRef'] ??
          json['mobileNumber'] ??
          json['phone'] ??
          '01234567890',
      floor: _formatFloor(json['payoutPosition'], cycleNum, json['floor']),
      timeAgo: _formatTimeAgo(json['submittedAt'] ?? json['createdAt'] ?? json['timeAgo']),
      amount: _parseAmount(rawAmount),
      status: _mapStatus(rawStatus),
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

  static String _formatTimeAgo(dynamic rawDate) {
    if (rawDate == null) return '15 دقيقة';
    final str = rawDate.toString();
    try {
      final dt = DateTime.parse(str);
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes <= 0 ? 15 : diff.inMinutes} دقيقة';
      }
      if (diff.inHours < 24) {
        return '${diff.inHours} ساعة';
      }
      return '${diff.inDays} يوم';
    } catch (_) {
      return str;
    }
  }

  static String _mapStatus(dynamic rawStatus) {
    final s = rawStatus.toString().toUpperCase();
    if (s == 'APPROVED' || s == 'SUCCESS' || s == 'SETTLED' || s == 'COMPLETED') {
      return 'success';
    }
    if (s == 'REJECTED' || s == 'FAILED' || s == 'DECLINED') {
      return 'failed';
    }
    return 'pending';
  }
}
