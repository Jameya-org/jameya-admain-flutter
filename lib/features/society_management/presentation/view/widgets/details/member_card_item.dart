import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/society_member_model.dart';

class MemberCardItem extends StatelessWidget {
  final SocietyMemberModel member;
  const MemberCardItem({super.key, required this.member});

  Color _getStatusColor() {
    if (member.status == 'مدفوع') return Colors.teal;
    if (member.status == 'معلق') return Colors.amber.shade700;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundImage: AssetImage(member.avatar),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 2.h),
                Text(member.phone, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                SizedBox(height: 2.h),
                Text('${member.role} - ${member.turn}', style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  member.status,
                  style: TextStyle(fontSize: 11.sp, color: _getStatusColor(), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12.h),
              Icon(Icons.arrow_back_ios_new, size: 14.sp, color: Colors.teal),
            ],
          ),
        ],
      ),
    );
  }
}
