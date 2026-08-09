import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';

class DocumentAccordionItem extends StatelessWidget {
  final MemberDocumentModel document;
  final VoidCallback onToggleExpand;
  final ValueChanged<DocumentVerificationStatus> onStatusChanged;
  final ValueChanged<String> onRejectionReasonChanged;
  final ValueChanged<String>? onImagePicked;

  const DocumentAccordionItem({
    super.key,
    required this.document,
    required this.onToggleExpand,
    required this.onStatusChanged,
    required this.onRejectionReasonChanged,
    this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    final bool isApproved =
        document.status == DocumentVerificationStatus.approved;
    final bool isRejected =
        document.status == DocumentVerificationStatus.rejected;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          InkWell(
            onTap: onToggleExpand,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Row(
                children: [
                  Text(
                    document.title,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    document.isExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.chevron_left_rounded,
                    color: AppColors.primary,
                    size: 30.sp,
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content
          if (document.isExpanded) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
              ).copyWith(bottom: 14.h),
              child: Column(
                children: [
                  // Image Preview Box
                  GestureDetector(
                    onTap: () async {
                      if (onImagePicked != null) {
                        // We will call the callback, picking logic will be in the parent View
                        onImagePicked!('');
                      }
                    },
                    child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: document.localImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(
                                File(document.localImagePath!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : (document.imageUrl.startsWith('http') &&
                                !document.imageUrl.contains('placeholder'))
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                document.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : Icon(
                              Icons.image_outlined,
                              size: 48.sp,
                              color: Colors.grey.shade500,
                            ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Approve & Reject Buttons Row
                  Row(
                    children: [
                      // Approve Button on Right (first in RTL Row)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onStatusChanged(
                              DocumentVerificationStatus.approved,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isApproved
                                ? const Color(0xFF1E8E3E)
                                : Color(0xff008080),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                          ),
                          child: Text(
                            'قبول',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 32.w),
                      // Reject Button on Left (second in RTL Row)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            onStatusChanged(
                              DocumentVerificationStatus.rejected,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isRejected
                                  ? Colors.red
                                  : AppColors.primary,
                              width: 1.5,
                            ),
                            backgroundColor: isRejected
                                ? Colors.red.shade50
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                          ),
                          child: Text(
                            'رفض',
                            style: TextStyle(
                              color: isRejected
                                  ? Colors.red
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Rejection Reason Field
                  if (isRejected) ...[
                    SizedBox(height: 14.h),
                    TextField(
                      onChanged: onRejectionReasonChanged,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'سبب الرفض',
                        hintStyle: TextStyle(
                          color: Color(0xff797979),
                          fontSize: 16.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
