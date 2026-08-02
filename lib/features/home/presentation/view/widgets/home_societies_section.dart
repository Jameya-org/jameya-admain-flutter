import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya/core/routing/routes.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';
import 'package:jameya/features/society_management/data/models/society_model.dart';

class HomeSocietiesSection extends StatelessWidget {
  const HomeSocietiesSection({
    super.key,
    required this.onNavigateToSocieties,
  });

  final VoidCallback onNavigateToSocieties;

  @override
  Widget build(BuildContext context) {
    // Sample societies matching the screenshot design
    final societies = [
      SocietyModel(
        id: '1',
        name: 'جمعية 12 شهر',
        code: '135352',
        status: 'نشطة',
        currentTurn: 5,
        monthlyAmount: 1000,
        startDate: '01/01/2024',
        endDate: '01/12/2024',
        duration: '12 شهر',
        iconType: 'chart',
      ),
      SocietyModel(
        id: '2',
        name: 'جمعية 12 شهر',
        code: '125352',
        status: 'مكتملة',
        currentTurn: 12,
        monthlyAmount: 2000,
        startDate: '01/01/2024',
        endDate: '01/12/2024',
        duration: '12 شهر',
        iconType: 'chart',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          children: [
            Text(
              'متابعة الجمعيات',
              style: AppTextStyles.headline.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onNavigateToSocieties,
              child: Text(
                'عرض المزيد',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.grey500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Horizontal list of cards
        SizedBox(
          height: 195.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: societies.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final society = societies[index];
              return _buildSocietyCard(context, society);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSocietyCard(BuildContext context, SocietyModel society) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.kSocietyDetailsView, extra: society);
      },
      child: Container(
        width: 285.w,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.grey200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Title + Code (RIGHT) & Active Badge (LEFT)
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      society.name,
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'كود: ${society.code}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    society.status,
                    style: TextStyle(
                      color: const Color(0xFF1E8E3E),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Middle Status & Details Row
            Row(
              children: [
                Container(
                  width: 7.w,
                  height: 7.h,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'مكتملة',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(Icons.refresh, size: 14.sp, color: AppColors.grey500),
                SizedBox(width: 2.w),
                Text(
                  'الدور الحالي : ${society.currentTurn}',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),

            // Members & Installment Row
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Members Count.svg',
                      width: 14.w,
                      height: 14.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey500,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '12 عضو',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/MonthlyInstallment.svg',
                      width: 14.w,
                      height: 14.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey500,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'القسط الشهري: ${society.monthlyAmount.toInt()}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Divider(height: 1, color: AppColors.grey200),

            // Dates Row: StartDate & EndDate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/StartDate.svg',
                      width: 14.w,
                      height: 14.h,
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'البداية',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10.sp,
                            color: AppColors.grey500,
                          ),
                        ),
                        Text(
                          society.startDate,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 20.h,
                  width: 1,
                  color: AppColors.grey300,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/EndDate.svg',
                      width: 14.w,
                      height: 14.h,
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'النهاية',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10.sp,
                            color: AppColors.grey500,
                          ),
                        ),
                        Text(
                          society.endDate,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
