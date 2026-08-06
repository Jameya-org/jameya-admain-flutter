import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMetricBadgesRow extends StatelessWidget {
  const PaymentMetricBadgesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _badge('4', 'الإجمالي', Colors.teal)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('3', 'قادمة', Colors.grey.shade700)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('1', 'جزئية', Colors.amber.shade800)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('4', 'مكتملة', Colors.teal)),
      ],
    );
  }

  Widget _badge(String count, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
