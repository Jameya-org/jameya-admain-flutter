import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya/core/utils/app_colors.dart';
import 'package:jameya/core/utils/app_text_styles.dart';
import 'package:jameya/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:jameya/features/home/presentation/manager/home_cubit/home_state.dart';

class HomeStatsGrid extends StatelessWidget {
  const HomeStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeDashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeDashboardLoaded) {
          final stats = [
            {'title': 'الجمعيات النشطة', 'value': '${state.dashboard.circles.inProgress}'},
            {'title': 'الاعضاء النشطون', 'value': '${state.dashboard.circles.totalActiveMembers}'},
            {'title': 'توثيقات معلقة', 'value': '${state.dashboard.kyc.pendingReview}'},
            {'title': 'عملاء مرفوضين', 'value': '${state.dashboard.kyc.rejectedToday}'},
          ];

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.55,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final item = stats[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title on TOP
                    Text(
                      item['title']!,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 12.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Value BELOW title
                    Text(
                      item['value']!,
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is HomeDashboardError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
