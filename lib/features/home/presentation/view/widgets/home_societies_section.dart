import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya/core/routing/routes.dart';
import 'package:jameya/core/services/services_locator.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';
import 'package:jameya/features/society_management/data/models/society_model.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_cubit.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_state.dart';

class HomeSocietiesSection extends StatelessWidget {
  const HomeSocietiesSection({
    super.key,
    required this.onNavigateToSocieties,
  });

  final VoidCallback onNavigateToSocieties;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SocietyCubit>()..fetchSocieties(),
      child: Column(
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

          // Dynamic API Societies
          BlocBuilder<SocietyCubit, SocietyState>(
            builder: (context, state) {
              if (state is SocietyLoading) {
                return SizedBox(
                  height: 195.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is SocietyError) {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تعذر تحميل الجمعيات',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.red,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: () => context.read<SocietyCubit>().fetchSocieties(),
                          child: Text(
                            'إعادة المحاولة',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is SocietyLoaded) {
                final societies = state.societies;

                if (societies.isEmpty) {
                  return Container(
                    height: 100.h,
                    alignment: Alignment.center,
                    child: Text(
                      'لا توجد جمعيات حالياً',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.grey500,
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 205.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: societies.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final society = societies[index];
                      return _buildSocietyCard(context, society);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocietyCard(BuildContext context, SocietyModel society) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.kSocietyDetailsView, extra: society);
      },
      child: Container(
        width: 295.w,
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
            // Top Row: Title + Code (RIGHT) & Status Badge (LEFT)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        society.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                ),
                SizedBox(width: 8.w),
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

            // Middle Status & Turn Row
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
                  society.status,
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

            // Duration & Installment Row
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
                      society.duration,
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
                      'القسط الشهري: ${society.monthlyAmount.toInt()} ج.م',
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

            // Dates Row: StartDate & EndDate with 24px SVG Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateCol(
                  'assets/icons/EndDate.svg',
                  'النهاية',
                  society.endDate,
                ),
                Container(
                  height: 24.h,
                  width: 1,
                  color: AppColors.grey300,
                ),
                _buildDateCol(
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

  Widget _buildDateCol(String svgPath, String label, String rawDate) {
    String formatted = rawDate;
    if (rawDate.length > 10 && rawDate.contains('T')) {
      formatted = rawDate.substring(0, 10);
    }

    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 24.w,
          height: 24.h,
        ),
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontSize: 11.sp,
                color: AppColors.grey500,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              formatted.isEmpty ? '—' : formatted,
              style: AppTextStyles.caption.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
