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
      title: 'طلبات الانضمام',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        useMaterial3: true,
      ),

      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      home: const JoinRequestsPage(),
    );
  }
}

class JoinRequestsPage extends StatefulWidget {
  const JoinRequestsPage({super.key});

  @override
  State<JoinRequestsPage> createState() => _JoinRequestsPageState();
}

class _JoinRequestsPageState extends State<JoinRequestsPage> {
  static const Color primaryTeal = Color(0xFF0E8E7E);

  int _selectedFilter = 2; // 0 = قيد المراجعة, 1 = جديد, 2 = الكل
  int _selectedNavIndex = 4; // الرئيسية selected

  final List<Map<String, String>> requests = const [
    {
      'status': 'جديد',
      'name': 'محمد احمد علي',
      'phone': '01234567890',
      'amount': 'جمعية 12,000 ج.م',
      'floor': 'الدور الرابع',
    },
    {
      'status': 'جديد',
      'name': 'محمد احمد علي',
      'phone': '01234567890',
      'amount': 'جمعية 36,000 ج.م',
      'floor': 'الدور الرابع',
    },
    {
      'status': 'قيد المراجعة',
      'name': 'محمد احمد علي',
      'phone': '01234567890',
      'amount': 'جمعية 24,000 ج.م',
      'floor': 'الدور الرابع',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildFilterChips(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final item = requests[index];
                  return _RequestCard(
                    status: item['status']!,
                    name: item['name']!,
                    phone: item['phone']!,
                    amount: item['amount']!,
                    floor: item['floor']!,
                    primaryTeal: primaryTeal,
                  );
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
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.chevron_right, color: primaryTeal, size: 26),
          const Expanded(
            child: Center(
              child: Text(
                'طلبات الانضمام',
                style: TextStyle(
                  color: primaryTeal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 26),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'بحث بالأسم او رقم الهاتف',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              Icon(Icons.search, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final labels = ['قيد المراجعة', 'جديد', 'الكل'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: List.generate(labels.length, (index) {
          final bool isSelected = _selectedFilter == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryTeal : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primaryTeal : const Color(0xFFE0E0E0),
                  ),
                ),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.person_outline, 'label': 'حسابي'},
      {'icon': Icons.payments_outlined, 'label': 'المدفوعات'},
      null,
      {'icon': Icons.groups_outlined, 'label': 'الجمعيات'},
      {'icon': Icons.home_outlined, 'label': 'الرئيسية'},
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            if (item == null) {
              return const SizedBox(width: 40);
            }
            final bool isSelected = index == _selectedNavIndex;
            final color = isSelected ? primaryTeal : Colors.grey;
            return InkWell(
              onTap: () => setState(() => _selectedNavIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item['icon'] as IconData, color: color, size: 24),
                  const SizedBox(height: 2),
                  Text(
                    item['label'] as String,
                    style: TextStyle(color: color, fontSize: 11),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String status;
  final String name;
  final String phone;
  final String amount;
  final String floor;
  final Color primaryTeal;

  const _RequestCard({
    required this.status,
    required this.name,
    required this.phone,
    required this.amount,
    required this.floor,
    required this.primaryTeal,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNew = status == 'جديد';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // status badge (top-left in RTL = "end" side)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isNew
                      ? const Color(0xFFDFF3E3)
                      : const Color(0xFFF5E9D0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isNew
                        ? const Color(0xFF2E9E4B)
                        : const Color(0xFFA07A24),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text info block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      floor,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Avatar photo
              ClipOval(
                child: Image.asset(
                  'assets/person1 1.jpg',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.chevron_left, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
