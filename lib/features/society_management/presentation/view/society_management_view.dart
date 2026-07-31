import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/society_cubit.dart';
import 'widgets/society_search_bar.dart';
import 'widgets/society_filter_tabs.dart';
import 'widgets/society_list_view.dart';

class SocietyManagementView extends StatelessWidget {
  const SocietyManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocietyCubit()..fetchSocieties(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'إدارة الجمعيات',
            style: TextStyle(color: const Color(0xFF00796B), fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: const Color(0xFF00796B), size: 20.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              const SocietySearchBar(),
              SizedBox(height: 16.h),
              SocietyFilterTabs(),
              SizedBox(height: 16.h),
              const Expanded(child: SocietyListView()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF00796B),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, 'الرئيسية', false),
              _navItem(Icons.refresh, 'الجمعيات', true),
              SizedBox(width: 40.w), // space for FAB
              _navItem(Icons.payment_outlined, 'المدفوعات', false),
              _navItem(Icons.person_outline, 'حسابي', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF00796B) : Colors.grey, size: 24.sp),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF00796B) : Colors.grey, fontSize: 12.sp)),
      ],
    );
  }
}
