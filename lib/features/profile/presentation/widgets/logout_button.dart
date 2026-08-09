import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Transform(
            alignment: Alignment.center,
            transform: Directionality.of(context) == TextDirection.rtl
                ? Matrix4.rotationY(3.1416)
                : Matrix4.identity(),
            child: Icon(
              Icons.logout,
              color: AppColors.error,
              size: 22.sp,
            ),
          ),
          label: Text(
            'تسجيل الخروج',
            style: AppTextStyles.body.copyWith(
              color: AppColors.error,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFFFE8E8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }
}