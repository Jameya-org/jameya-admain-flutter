import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/features/society_management/data/models/society_payment_model.dart';

class PaymentMetricBadgesRow extends StatelessWidget {
  final List<SocietyPaymentModel> payments;
  const PaymentMetricBadgesRow({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    final total = payments.length;
    final completed = payments.where((p) => p.status == 'مدفوع').length;
    final pending = payments.where((p) => p.status == 'معلق').length;
    final upcoming = payments.where((p) => p.status == 'قادم').length;

    return Row(
      children: [
        Expanded(child: _badge('$total', 'الإجمالي', Colors.teal)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('$upcoming', 'قادمة', Colors.grey.shade700)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('$pending', 'جزئية/معلقة', Colors.amber.shade800)),
        SizedBox(width: 8.w),
        Expanded(child: _badge('$completed', 'مكتملة', Colors.teal)),
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
