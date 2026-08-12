import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../models/member_details_model.dart';

class MemberTabs extends StatelessWidget {
  const MemberTabs({
    super.key,
    required this.member,
    this.currentIndex = 0,
  });

  final MemberDetailsModel member;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      child: Row(
        children: [
          // =========================
          // نظرة عامة
          // =========================
          _item(
            context,
            title: 'نظرة عامة',
            index: 0,
            route: '${AppRoutes.memberDetails}/${member.id}',
          ),

          // =========================
          // الدوائر
          // =========================
          _item(
            context,
            title: 'الدوائر',
            index: 1,
            route: AppRoutes.memberCircles,
          ),

          // =========================
          // المدفوعات
          // =========================
          _item(
            context,
            title: 'المدفوعات',
            index: 2,
            route: AppRoutes.memberPayments,
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context, {
        required String title,
        required int index,
        required String route,
      }) {
    final bool selected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          // لو التاب الحالي متعلم، مفيش داعي نعمل navigation
          if (selected) return;

          // =========================
          // نظرة عامة
          // =========================
          if (index == 0) {
            context.pushReplacement(route);
            return;
          }

          // =========================
          // الدوائر / المدفوعات
          // =========================
          context.pushReplacement(
            route,
            extra: member,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? AppColors.accent
                    : AppColors.grey200,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.body.copyWith(
                fontSize: 15.sp,
                color: selected
                    ? AppColors.primary
                    : AppColors.textHint,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}