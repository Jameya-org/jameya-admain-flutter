import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../models/member_details_model.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({
    super.key,
    required this.member,
  });

  final MemberDetailsModel member;

  Widget rowItem(
      String title,
      String value, {
        bool isStatus = false,
        String? status,
      }) {
    Color backgroundColor = const Color(0xffE8FFF3);
    Color textColor = AppColors.primary;

    if (isStatus) {
      switch (status?.toUpperCase()) {
        case 'APPROVED':
          backgroundColor = const Color(0xffE8FFF3);
          textColor = AppColors.primary;
          break;

        case 'PENDING':
        case 'UNDER_REVIEW':
          backgroundColor = const Color(0xffFFF2DD);
          textColor = const Color(0xffE19A00);
          break;

        case 'REJECTED':
          backgroundColor = Colors.white;
          textColor = Colors.black87;
          break;

        case 'NOT_STARTED':
        default:
          backgroundColor = const Color(0xffF5F5F5);
          textColor = Colors.grey;
          break;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
          ),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: isStatus
                  ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  value,
                  style: AppTextStyles.label.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
                  : Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get kycStatus {
    switch (member.identityProfile.kycStatus) {
      case 'APPROVED':
        return 'موثق';

      case 'PENDING':
      case 'UNDER_REVIEW':
        return 'قيد المراجعة';

      case 'REJECTED':
        return 'مرفوض';

      default:
        return 'غير موثق';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'معلومات شخصية',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          rowItem(
            'حالة الحساب',
            kycStatus,
            isStatus: true,
            status: member.identityProfile.kycStatus,
          ),

          rowItem(
            'الاسم الكامل',
            member.legalName,
          ),

          rowItem(
            'رقم الهاتف',
            member.mobileNumber,
          ),

          rowItem(
            'البريد الإلكتروني',
            member.email,
          ),

          rowItem(
            'رقم الهوية القومية',
            member.identityProfile.nationalId,
          ),

          rowItem(
            'المدينة',
            member.identityProfile.city,
          ),

          rowItem(
            'تاريخ التسجيل',
            member.createdAt
                .toString()
                .substring(0, 10),
          ),
        ],
      ),
    );
  }
}