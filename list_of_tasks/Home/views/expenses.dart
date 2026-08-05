import 'package:flutter/material.dart';

const Color primaryTeal = Color(0xFF009688);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ExpensesScreen(),
    );
  }
}

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = [
      Expense(
        amount: "10,800",
        name: "احمد علي سامح",
        phone: "01234567890",
        floor: "الدور الرابع",
      ),
      Expense(
        amount: "24,000",
        name: "احمد علي سامح",
        phone: "01234567890",
        floor: "الدور السابع",
      ),
      Expense(
        amount: "36,000",
        name: "احمد علي سامح",
        phone: "01234567890",
        floor: "الدور التاسع",
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryTeal,
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNavBar(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "المصروفات",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff009688),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            "عدد العمليات",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "3",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff009688),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 45,
                      color: Colors.grey.shade300,
                    ),

                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            "إجمالي المبلغ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "72,000 ج.م",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff009688),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "اليوم",
                  style: TextStyle(
                    color: Color(0xff009688),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ...expenses.map((e) => ExpenseCard(expense: e)),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "1-8-2026",
                  style: TextStyle(
                    color: Color(0xff009688),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ExpenseCard(
                expense: Expense(
                  amount: "36,000",
                  name: "احمد علي سامح",
                  phone: "01234567890",
                  floor: "الدور التاسع",
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    expense.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    expense.phone,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    expense.floor,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${expense.amount} ج.م",
                  style: const TextStyle(
                    color: Color(0xff009688),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009688),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "تأكيد الدفع",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Expense {
  final String amount;
  final String name;
  final String phone;
  final String floor;

  Expense({
    required this.amount,
    required this.name,
    required this.phone,
    required this.floor,
  });
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool selected;

  const NavItem(this.icon, this.text, this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xff009688) : Colors.grey;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(text, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}
