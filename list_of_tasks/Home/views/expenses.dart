import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // دعم اللغة العربية واتجاه الكتابة من اليمين لليسار
      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        primaryColor: const Color(0xFF0F6E5F),
        fontFamily: 'Cairo',
      ),
      home: const ExpensesScreen(),
    );
  }
}

// موديل بيانات العملية
class TransactionItem {
  final String amount;
  final String name;
  final String phone;
  final String date;
  bool isConfirmed; // حالة تأكيد الدفع

  TransactionItem({
    required this.amount,
    required this.name,
    required this.phone,
    required this.date,
    this.isConfirmed = false,
  });
}

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final Color primaryColor = const Color(0xFF0F6E5F);

  // بيانات وهمية مطابقة للتصميم
  final List<TransactionItem> todayTransactions = [
    TransactionItem(
      amount: '10,800',
      name: 'احمد علي سامح',
      phone: '01234567890',
      date: 'الدور الرابع',
    ),
    TransactionItem(
      amount: '24,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      date: 'الدور السابع',
    ),
    TransactionItem(
      amount: '36,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      date: 'الدور التاسع',
    ),
  ];

  final List<TransactionItem> previousTransactions = [
    TransactionItem(
      amount: '36,000',
      name: 'احمد علي سامح',
      phone: '01234567890',
      date: 'الدور الثاني',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المصروفات',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
          size: 18,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 20),
            const Text(
              'اليوم',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...todayTransactions.map((t) => _buildTransactionCard(t)),
            const SizedBox(height: 16),
            const Text(
              '1-8-2026',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...previousTransactions.map((t) => _buildTransactionCard(t)),
          ],
        ),
      ),
    );
  }

  // كارت الملخص العلوي (إجمالي المبلغ - عدد العمليات)
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'عدد العمليات',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 6),
              Text(
                '3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'اجمالي المبلغ',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 6),
              Text(
                '72,000 ج.م',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // كارت كل عملية مع زر تأكيد الدفع
  Widget _buildTransactionCard(TransactionItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.amount} ج.م',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Text(
                  item.phone,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  item.date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildConfirmButton(item),
        ],
      ),
    );
  }

  // زر تأكيد الدفع، يتغير نصه بعد الضغط
  Widget _buildConfirmButton(TransactionItem item) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: item.isConfirmed
            ? null // تعطيل الزر بعد التأكيد
            : () {
                setState(() {
                  item.isConfirmed = true;
                });
                // رسالة تأكيد سريعة (اختياري)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تأكيد الدفع بنجاح'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFF0F6E5F),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: item.isConfirmed
              ? Colors.grey.shade400
              : primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          item.isConfirmed ? 'تم التأكيد' : 'تأكيد الدفع',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
