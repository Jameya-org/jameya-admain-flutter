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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          child: Text(
            'إجراءات سريعة',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _actionBtn(
                'تعديل الدائرة',
                'assets/icons/dit_information.svg',
                const Color(0xFF00CECD),
                const Color(0xFFE0F9F9),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _actionBtn(
                'جدول المدفوعات',
                'assets/icons/payment_schedule.svg',
                const Color(0xffE17100),
                const Color(0xFFFFF3E0),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _actionBtn(
          'ترتيب الصرف',
          'assets/icons/payout_order.svg',
          const Color(0xff9810FA),
          const Color(0xFFF3E5F5),
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _actionBtn(
    String label,
    String iconPath,
    Color iconColor,
    Color iconBgColor, {
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 20.sp,
              height: 20.sp,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
