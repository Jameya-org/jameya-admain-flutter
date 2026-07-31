import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_model.dart';
import 'circle_info_card.dart';
import 'circle_amounts_card.dart';
import 'quick_actions_grid.dart';

class OverviewTabView extends StatelessWidget {
  final SocietyModel society;
  const OverviewTabView({super.key, required this.society});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: CircleInfoCard(society: society),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const CircleAmountsCard(),
          ),
          SizedBox(height: 16.h),
          const QuickActionsGrid(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
