import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAmountsCard extends StatelessWidget {
  const CircleAmountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المبالغ', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        _amountRow('إجمالي قيمة الدائرة', '12,000 ج.م', Colors.black87),
        _amountRow('المبلغ المحصل', '5,000 ج.م', Colors.teal),
        _amountRow('المبلغ المتبقي', '7,000 ج.م', Colors.grey.shade700),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('40%', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
            Text('تحصيل 5.000 ج.م من 12.000 ج.م', style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500)),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: 0.4,
            minHeight: 8.h,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        ),
      ],
    );
  }

  Widget _amountRow(String title, String val, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600)),
          Text(val, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
