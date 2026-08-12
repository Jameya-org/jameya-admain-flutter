import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_text_styles.dart';

class AuthTitleSection extends StatelessWidget {
  const AuthTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                subtitle,
                textAlign: TextAlign.right,
                style: AppTextStyles.subtitle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
