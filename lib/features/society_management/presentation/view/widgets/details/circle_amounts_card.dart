import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/features/society_management/data/models/society_model.dart';

class CircleAmountsCard extends StatelessWidget {
  final SocietyModel society;
  const CircleAmountsCard({super.key, required this.society});

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF00CECD);

    final durationMonths = double.tryParse(society.duration) ?? 12;
    final totalValue = society.monthlyAmount * durationMonths;
    final collected = society.monthlyAmount * ((society.currentTurn - 1).clamp(0, durationMonths.toInt()));
    final remaining = (totalValue - collected).clamp(0.0, totalValue);
    final progress = totalValue > 0 ? (collected / totalValue).clamp(0.0, 1.0) : 0.0;
    final percentInt = (progress * 100).toInt();

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
        _amountRow('إجمالي قيمة الدائرة', '${totalValue.toStringAsFixed(0)} ج.م', Colors.black87),
        _divider(),
        _amountRow('المبلغ المحصل', '${collected.toStringAsFixed(0)} ج.م', tealColor),
        _divider(),
        _amountRow('المبلغ المتبقي', '${remaining.toStringAsFixed(0)} ج.م', Colors.black87),
        _divider(),
        _amountRow('نسبة الاكتمال', '$percentInt%', Colors.black87, isPercent: true),
        SizedBox(height: 12.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: Colors.grey.shade100,
            valueColor: const AlwaysStoppedAnimation<Color>(tealColor),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('تحصيل ${collected.toStringAsFixed(0)} ج.م', style: TextStyle(fontSize: 11.sp, color: tealColor, fontWeight: FontWeight.w600)),
            Text('${totalValue.toStringAsFixed(0)} ج.م', style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400, fontWeight: FontWeight.w500)),
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
