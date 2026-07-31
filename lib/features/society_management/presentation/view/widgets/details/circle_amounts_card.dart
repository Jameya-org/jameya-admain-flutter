import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAmountsCard extends StatelessWidget {
  const CircleAmountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF00CECD);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            'المبالغ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        _amountRow('إجمالي قيمة الدائرة', '12,000 ج.م', Colors.black87),
        _divider(),
        _amountRow('المبلغ المحصل', '5,000 ج.م', tealColor),
        _divider(),
        _amountRow('المبلغ المتبقي', '7,000 ج.م', Colors.black87),
        _divider(),
        _amountRow('نسبة الاكتمال', '40%', Colors.black87, isPercent: true),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: 0.4,
            minHeight: 8.h,
            backgroundColor: Colors.grey.shade100,
            valueColor: const AlwaysStoppedAnimation<Color>(tealColor),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('تحصيل 5,000 ج.م', style: TextStyle(fontSize: 11.sp, color: tealColor, fontWeight: FontWeight.w600)),
            Text('12,000 ج.م', style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade100, height: 16.h, thickness: 1);
  }

  Widget _amountRow(String title, String val, Color color, {bool isPercent = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
        ),
        Text(
          val,
          style: TextStyle(
            fontSize: isPercent ? 15.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
