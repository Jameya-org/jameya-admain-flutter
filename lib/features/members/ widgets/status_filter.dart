import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../presentation/view_model/members_cubit.dart';

class StatusFilter extends StatefulWidget {
  const StatusFilter({super.key});

  @override
  State<StatusFilter> createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildItem(
            title: 'الكل',
            index: 0,
            onTap: () {
              context.read<MembersCubit>().filterAll();
            },
          ),

          SizedBox(width: 10.w),

          _buildItem(
            title: 'موثق',
            index: 1,
            onTap: () {
              context.read<MembersCubit>().filterApproved();
            },
          ),

          SizedBox(width: 10.w),

          _buildItem(
            title: 'قيد المراجعة',
            index: 2,
            onTap: () {
              context.read<MembersCubit>().filterPending();
            },
          ),

          SizedBox(width: 10.w),

          _buildItem(
            title: 'معلق',
            index: 3,
            onTap: () {
              context.read<MembersCubit>().filterRejected();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required int index,
    required VoidCallback onTap,
  }) {
    final selected = selectedIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            color: selected
                ? Colors.white
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}