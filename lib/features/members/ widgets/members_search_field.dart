import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../presentation/view_model/members_cubit.dart';

class MembersSearchField extends StatefulWidget {
  const MembersSearchField({super.key});

  @override
  State<MembersSearchField> createState() => _MembersSearchFieldState();
}

class _MembersSearchFieldState extends State<MembersSearchField> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      onChanged: (value) {
        context.read<MembersCubit>().searchMembers(value);
      },
      decoration: InputDecoration(
        hintText: 'ابحث بالاسم أو رقم الهاتف',
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textHint,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textHint,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}