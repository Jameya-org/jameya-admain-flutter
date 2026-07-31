import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodel/society_cubit.dart';
import '../../viewmodel/society_state.dart';

class SocietyFilterTabs extends StatelessWidget {
  SocietyFilterTabs({super.key});

  final List<String> tabs = ['الكل', 'نشطة', 'مسددة', 'مكتملة', 'منتهية'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocietyCubit, SocietyState>(
      builder: (context, state) {
        String activeTab = 'الكل';
        if (state is SocietyLoaded) activeTab = state.activeTab;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tabs.map((tab) {
              final isActive = tab == activeTab;
              return GestureDetector(
                onTap: () => context.read<SocietyCubit>().changeTab(tab),
                child: Container(
                  margin: EdgeInsets.only(left: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF00796B) : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isActive ? const Color(0xFF00796B) : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade700,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
