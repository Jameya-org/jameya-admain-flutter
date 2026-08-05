import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مراجعة الدفعات',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFF7F8F9),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },

      locale: const Locale('ar'), // Set the default locale to Arabic
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const PaymentsReviewScreen(),
    );
  }
}

enum PaymentFilter { all, success, failed }

class PaymentItem {
  final String amount;
  final String name;
  final String phone;
  final String round;
  final String time;
  final bool isSuccess;

  PaymentItem({
    required this.amount,
    required this.name,
    required this.phone,
    required this.round,
    required this.time,
    required this.isSuccess,
  });
}

class PaymentsReviewScreen extends StatefulWidget {
  const PaymentsReviewScreen({super.key});

  @override
  State<PaymentsReviewScreen> createState() => _PaymentsReviewScreenState();
}

class _PaymentsReviewScreenState extends State<PaymentsReviewScreen> {
  PaymentFilter _selectedFilter = PaymentFilter.all;
  int _currentNavIndex = 3;
  final TextEditingController _searchController = TextEditingController();

  static const Color primaryTeal = Color(0xFF0E6E64);
  static const Color successGreenBg = Color(0xFFA9E4B8);
  static const Color successGreenText = Color(0xFF1B5E3A);
  static const Color failedRedBg = Color(0xFFF3B6B0);
  static const Color failedRedText = Color(0xFF8B2E24);

  final List<PaymentItem> _allPayments = [
    PaymentItem(
      amount: '1,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      round: 'الدور الرابع',
      time: 'منذ 15 دقيقة',
      isSuccess: true,
    ),
    PaymentItem(
      amount: '1,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      round: 'الدور الرابع',
      time: 'منذ 15 دقيقة',
      isSuccess: true,
    ),
    PaymentItem(
      amount: '1,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      round: 'الدور الرابع',
      time: 'منذ 15 دقيقة',
      isSuccess: false,
    ),
  ];

  List<PaymentItem> get _filteredPayments {
    switch (_selectedFilter) {
      case PaymentFilter.success:
        return _allPayments.where((p) => p.isSuccess).toList();
      case PaymentFilter.failed:
        return _allPayments.where((p) => !p.isSuccess).toList();
      case PaymentFilter.all:
        return _allPayments;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterRow(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredPayments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildPaymentCard(_filteredPayments[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryTeal,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24),
          const Text(
            'مراجعة الدفعات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryTeal,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right, color: primaryTeal, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'بحث بالأسم او رقم الهاتف',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ),
            Icon(
              Icons.search,
              color: Colors.grey.shade500,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          _filterChip('فاشلة', PaymentFilter.failed),
          const SizedBox(width: 10),
          _filterChip('ناجحة', PaymentFilter.success),
          const SizedBox(width: 10),
          _filterChip('الكل', PaymentFilter.all),
        ],
      ),
    );
  }

  Widget _filterChip(String label, PaymentFilter filter) {
    final bool isSelected = _selectedFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = filter),
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? primaryTeal : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryTeal : const Color(0xFFE5E7EB),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(PaymentItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDEEF0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.phone,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  item.round,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  item.time,
                  style: const TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.amount} ج.م',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTeal,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: item.isSuccess ? successGreenBg : failedRedBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.isSuccess ? 'ناجحة' : 'فاشلة',
                  style: TextStyle(
                    color: item.isSuccess ? successGreenText : failedRedText,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        textDirection: TextDirection.rtl,
        children: [
          _navItem(Icons.home_outlined, 'الرئيسية', 0),
          _navItem(Icons.sync, 'الجمعيات', 1),
          const SizedBox(width: 40),
          _navItem(Icons.payments_outlined, 'المدفوعات', 2),
          _navItem(Icons.person_outline, 'حسابي', 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = _currentNavIndex == index;
    final Color color = isSelected ? primaryTeal : Colors.black54;
    return GestureDetector(
      onTap: () => setState(() => _currentNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
