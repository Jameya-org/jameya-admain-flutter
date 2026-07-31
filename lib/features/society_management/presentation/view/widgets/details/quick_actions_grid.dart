import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إجراءات سريعة', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _actionBtn('تعديل المعلومات', 'assets/icons/dit_information.svg')),
            SizedBox(width: 8.w),
            Expanded(child: _actionBtn('تعديل المبالغ', 'assets/icons/payment_schedule.svg')),
            SizedBox(width: 8.w),
            Expanded(child: _actionBtn('ترتيب الصرف', 'assets/icons/payout_order.svg')),
          ],
        ),
      ],
    );
  }

  Widget _actionBtn(String label, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.sp, height: 24.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
