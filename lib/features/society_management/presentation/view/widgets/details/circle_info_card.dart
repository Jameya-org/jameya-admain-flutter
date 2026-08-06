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
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            'معلومات الجمعية',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _rowItem('الحالة', _statusChip(society.status)),
        _divider(),
        _rowItem(
          'كود الجمعية',
          Text(
            society.code.isNotEmpty ? society.code : 'JMY-2024-001',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _divider(),
        _rowItem(
          'مدة الدائرة',
          Text(
            society.duration.isNotEmpty ? society.duration : '12 شهر',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _divider(),
        _rowItem(
          'تاريخ البدء',
          Text(
            society.startDate.isNotEmpty ? society.startDate : '01/01/2024',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _divider(),
        _rowItem(
          'تاريخ الانتهاء',
          Text(
            society.endDate.isNotEmpty ? society.endDate : '01/12/2024',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade100, height: 16.h, thickness: 1);
  }

  Widget _statusChip(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7F6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.isNotEmpty ? status : 'نشطة',
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF00CECD),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _rowItem(String label, Widget valWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        valWidget,
      ],
    );
  }
}
