import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_model.dart';

class CircleInfoCard extends StatelessWidget {
  final SocietyModel society;
  const CircleInfoCard({super.key, required this.society});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('معلومات الدائرة', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        _rowItem('الحالة', _statusChip(society.status)),
        _rowItem('كود الجمعية', Text(society.code.isNotEmpty ? society.code : 'JMY-2024-001', style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700))),
        _rowItem('مدة الدائرة', Text(society.duration.isNotEmpty ? society.duration : '12 شهر', style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700))),
        _rowItem('تاريخ البدء', Text(society.startDate.isNotEmpty ? society.startDate : '01/01/2024', style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700))),
        _rowItem('تاريخ الانتهاء', Text(society.endDate.isNotEmpty ? society.endDate : '01/12/2024', style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700))),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(status.isNotEmpty ? status : 'نشطة', style: TextStyle(fontSize: 12.sp, color: Colors.teal, fontWeight: FontWeight.bold)),
    );
  }

  Widget _rowItem(String label, Widget valWidget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600)),
          valWidget,
        ],
      ),
    );
  }
}
