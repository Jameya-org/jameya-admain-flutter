import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';

class HomeTaskList extends StatelessWidget {
  const HomeTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        'title': 'توثيق الأعضاء',
        'icon': 'assets/icons/MemberVerification.svg',
        'hasBadge': true,
        'route': null, // مش متاح حالياً
      },
      {
        'title': 'إدارة الأعضاء',
        'icon': 'assets/icons/Member_Management.svg',
        'hasBadge': false,
        'route': AppRoutes.kMembersView,
      },
      {
        'title': 'المصروفات',
        'icon': 'assets/icons/Expenses.svg',
        'hasBadge': false,
        'route': AppRoutes.kExpensesView,
      },
      {
        'title': 'مراجعة الدفعات',
        'icon': 'assets/icons/Payment Review.svg',
        'hasBadge': false,
        'route': AppRoutes.kReviewPaymentsView,
      },
      {
        'title': 'دفعات متأخرة',
        'icon': 'assets/icons/Overdue Payments.svg',
        'hasBadge': true,
        'route': AppRoutes.kOverduePaymentsView,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قائمة المهام',
          style: AppTextStyles.headline.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            children: List.generate(tasks.length, (index) {
              final task = tasks[index];
              final isLast = index == tasks.length - 1;
              final bool hasBadge = task['hasBadge'] as bool;
              final String? route = task['route'] as String?;

              return Column(
                children: [
                  InkWell(
                    onTap: route != null ? () => context.push(route) : null,
                    borderRadius: BorderRadius.circular(24.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          // 1. Task SVG Icon (First child in RTL = RIGHT edge)
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SvgPicture.asset(
                                task['icon'] as String,
                                width: 44.w,
                                height: 44.h,
                                fit: BoxFit.contain,
                              ),
                              if (hasBadge)
                                Positioned(
                                  top: 1.h,
                                  right: 1.w,
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          // 2. Task Title Text
                          Text(
                            task['title'] as String,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          // 3. Right chevron arrow reversed for RTL
                          Transform.flip(
                            flipX: true,
                            child: Icon(
                              Icons.chevron_left,
                              size: 22.sp,
                              color: route != null
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFFCBD5E1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: 16.w,
                      endIndent: 16.w,
                      color: const Color(0xFFE2E8F0),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
