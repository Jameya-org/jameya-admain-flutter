import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import '../../../data/models/society_model.dart';
import 'package:go_router/go_router.dart';

class SocietyCard extends StatelessWidget {
  final SocietyModel society;
  const SocietyCard({super.key, required this.society});

  Color _getStatusColor() {
    switch (society.status) {
      case 'نشطة':
        return Color(0xFFB1FFC5).withValues(alpha: 0.3);
      case 'مسودة':
        return Color(0xFFE9D5B3).withValues(alpha: 0.5);
      case 'مكتملة':
        return Color(0xFFD6E4FF);
      case 'منتهية':
        return Color(0xFFFDFDFD);
      case 'دفعات متأخرة':
        return Color(0xFFFFD6DB);
      default:
        return Color(0xFFB1FFC5);
    }
  }

  Color _getStatusTextColor() {
    switch (society.status) {
      case 'نشطة':
        return AppColors.primary;
      case 'مسودة':
        return Color(0xFFF59E0B);
      case 'مكتملة':
        return Color(0xFF2563EB);
      case 'منتهية':
        return Color(0xFF282828);
      case 'دفعات متأخرة':
        return Color(0xFFB91C1C);
      default:
        return Color(0xFFB91C1C);
    }
  }

  double _getProgress() {
    final totalDuration = int.tryParse(society.duration) ?? 0;
    if (totalDuration <= 0) return 0;
    final progress = society.currentTurn / totalDuration;
    return progress.clamp(0.0, 1.0);
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
              color: Colors.black.withValues(alpha: 0.05),
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
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    society.status,
                    style: TextStyle(
                      color: _getStatusTextColor(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _getStatusTextColor(),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  society.status,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/Refresh.svg',
                  width: 18.w,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    Color(0xff181818).withValues(alpha: 0.5),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'الدور الحالي: ${society.currentTurn}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: _getProgress(),
                minHeight: 4.h,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),

            SizedBox(height: 14.h),

            Row(
              children: [
                Expanded(
                  child: _buildStatBox(
                    iconAsset: 'assets/icons/Members Count.svg',
                    text: society.duration,
                  ),
                ),

                SizedBox(width: 10.w),
                Expanded(
                  child: _buildStatBox(
                    iconAsset: 'assets/icons/MonthlyInstallment.svg',
                    text: '${society.monthlyAmount.toStringAsFixed(0)} ج.م',
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            Divider(height: 1.h, color: Colors.grey.shade200),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCol(
                  'assets/icons/EndDate.svg',
                  'النهاية',
                  society.endDate,
                ),
                Container(
                  width: 1.w,
                  height: 32.h,
                  color: Colors.grey.shade200,
                ),
                _buildInfoCol(
                  'assets/icons/StartDate.svg',
                  'البداية',
                  society.startDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox({required String iconAsset, required String text}) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 18.w,
            height: 18.h,
            colorFilter: ColorFilter.mode(Colors.teal, BlendMode.srcIn),
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCol(String svgAsset, String label, String rawDate) {
    String formatted = rawDate;
    if (rawDate.length > 10 && rawDate.contains('T')) {
      formatted = rawDate.substring(0, 10);
    }

    return Row(
      children: [
        SvgPicture.asset(svgAsset, width: 20.w, height: 20.h),
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
            ),
            SizedBox(height: 2.h),
            Text(
              formatted.isEmpty ? '—' : formatted,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

