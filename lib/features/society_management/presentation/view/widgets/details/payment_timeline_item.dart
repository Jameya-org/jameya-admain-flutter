import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_payment_model.dart';

class PaymentTimelineItem extends StatelessWidget {
  final SocietyPaymentModel payment;
  const PaymentTimelineItem({super.key, required this.payment});

  Color _getStatusColor() {
    if (payment.status == 'مدفوع') return Colors.teal;
    if (payment.status == 'معلق') return Colors.amber.shade800;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(payment.monthName, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2.h),
                  Text('استحقاق : ${payment.dueDate}', style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(payment.status, style: TextStyle(fontSize: 11.sp, color: _getStatusColor(), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text('${payment.amount.toInt()} ج.م', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: payment.status == 'مدفوع' ? 1.0 : (payment.status == 'معلق' ? 0.8 : 0.0),
              minHeight: 6.h,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              _indicatorDot(Colors.teal, '${payment.paidCount} دفع'),
              SizedBox(width: 12.w),
              _indicatorDot(Colors.amber.shade800, '${payment.pendingCount} معلق'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indicatorDot(Color color, String txt) {
    return Row(
      children: [
        Container(width: 6.w, height: 6.w, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 4.w),
        Text(txt, style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600)),
      ],
    );
  }
}
