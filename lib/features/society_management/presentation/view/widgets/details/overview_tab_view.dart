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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // معلومات الدائرة
          _card(child: CircleInfoCard(society: society)),
          SizedBox(height: 12.h),
          // المبالغ
          _card(child: const CircleAmountsCard()),
          SizedBox(height: 12.h),
          // الإجراءات السريعة
          const QuickActionsGrid(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
