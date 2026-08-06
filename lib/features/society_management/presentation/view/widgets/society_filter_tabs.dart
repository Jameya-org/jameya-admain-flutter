import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya/core/utils/app_colors.dart';
import '../../viewmodel/society_cubit.dart';
import '../../viewmodel/society_state.dart';

class SocietyFilterTabs extends StatelessWidget {
  SocietyFilterTabs({super.key});

  final List<String> tabs = [
    'الكل',
    'نشطة',
    'مسودة',
    'مكتملة',
    'منتهية',
    'دفعات متأخرة',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocietyCubit, SocietyState>(
      builder: (context, state) {
        String activeTab = 'الكل';
        if (state is SocietyLoaded) activeTab = state.activeTab;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: tabs.map((tab) {
              final isActive = tab == activeTab;
              return GestureDetector(
                onTap: () => context.read<SocietyCubit>().changeTab(tab),
                child: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isActive ? AppColors.primary : AppColors.border,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: GoogleFonts.inter(
                      color: isActive ? Colors.white : AppColors.textPrimary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 16.sp,
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
