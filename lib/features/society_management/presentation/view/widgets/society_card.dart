import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/routing/routes.dart';
import '../../../data/models/society_model.dart';
import 'package:go_router/go_router.dart';

class SocietyCard extends StatelessWidget {
  final SocietyModel society;
  const SocietyCard({super.key, required this.society});

  Color _getStatusColor() {
    switch (society.status) {
      case 'نشطة':
        return Colors.teal;
      case 'مسددة':
        return Colors.amber;
      case 'منتهية':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.kSocietyDetailsView, extra: society),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
                    Text(
                      society.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'كود: ${society.code}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    society.status,
                    style: TextStyle(color: _getStatusColor(), fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.stars, color: Colors.teal, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  'الدور الحالي: ${society.currentTurn}',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
            Divider(height: 24.h, color: Colors.grey.shade200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCol(
                  Icons.people,
                  society.duration,
                  Icons.calendar_today,
                  'البداية',
                  society.startDate,
                ),
                Container(
                  width: 1.w,
                  height: 40.h,
                  color: Colors.grey.shade200,
                ),
                _buildInfoCol(
                  Icons.payments,
                  '${society.monthlyAmount} ج.م',
                  Icons.calendar_today,
                  'النهاية',
                  society.endDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCol(
    IconData topIcon,
    String topTxt,
    IconData botIcon,
    String botLbl,
    String botTxt,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(topIcon, size: 16.sp, color: Colors.teal),
            SizedBox(width: 4.w),
            Text(
              topTxt,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(botIcon, size: 14.sp, color: Colors.grey),
            SizedBox(width: 4.w),
            Text(
              '$botLbl: $botTxt',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
