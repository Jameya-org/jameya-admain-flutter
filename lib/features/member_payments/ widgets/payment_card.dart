import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

import '../../member_details/models/member_details_model.dart';
import 'payment_status_badge.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.installment,
  });

  final InstallmentModel installment;

  @override
  Widget build(BuildContext context) {
    final bool paid =
        installment.status.toUpperCase() == 'PAID';

    final bool overdue =
        installment.status.toUpperCase() == 'OVERDUE';

    final String status = _statusText(
      installment.status,
    );

    return SizedBox(
      height: paid ? 112.h : 84.h,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // Timeline
          // =========================
          Column(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: paid
                      ? AppColors.accent
                      : const Color(0xffF5A623),
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(height: 4.h),

              Expanded(
                child: Container(
                  width: 1.5.w,
                  margin: EdgeInsets.only(
                    bottom: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: paid
                        ? AppColors.accent
                        : const Color(0xffF5A623),
                    borderRadius:
                    BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 4.w),

          // =========================
          // Card
          // =========================
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                BorderRadius.circular(18.r),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Stack(
                children: [
                  // =========================
                  // Status
                  // =========================
                  Positioned(
                    left: 0,
                    top: 0,
                    child: PaymentStatusBadge(
                      status: status,
                    ),
                  ),

                  // =========================
                  // Title + Date
                  // =========================
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textDirection:
                          TextDirection.rtl,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                'جمعية شهر ${installment.circleDurationMonths} | ',
                                style: AppTextStyles
                                    .subtitle
                                    .copyWith(
                                  color:
                                  AppColors.textPrimary,
                                  fontSize: 18.sp,
                                ),
                              ),
                              TextSpan(
                                text: _formatMonth(
                                  installment.dueDate,
                                ),
                                style: AppTextStyles
                                    .subtitle
                                    .copyWith(
                                  color:
                                  AppColors.grey500,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 1.h),

                        Text(
                          'استحقاق: ${_formatDate(installment.dueDate)}',
                          style: AppTextStyles
                              .bodySmall
                              .copyWith(
                            color:
                            AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =========================
                  // Paid Information
                  // =========================
                  if (paid) ...[
                    // Amount
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text(
                        '${_formatAmount(installment.amount)} ج.م',
                        style: AppTextStyles
                            .subtitle
                            .copyWith(
                          color:
                          AppColors.textPrimary,
                          fontWeight:
                          FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),

                    // Payment Method
                    if (installment.paymentChannel !=
                        null)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                            AppColors.grey100,
                            borderRadius:
                            BorderRadius.circular(
                              18.r,
                            ),
                          ),
                          child: Row(
                            mainAxisSize:
                            MainAxisSize.min,
                            textDirection:
                            TextDirection.rtl,
                            children: [
                              Text(
                                _paymentChannelText(
                                  installment
                                      .paymentChannel!,
                                ),
                                style: AppTextStyles
                                    .label
                                    .copyWith(
                                  color: AppColors
                                      .textHint,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.wallet_outlined,
                                size: 14.sp,
                                color:
                                AppColors.textHint,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusText(String status) {
    switch (status.toUpperCase()) {
      case 'PAID':
        return 'مدفوع';

      case 'OVERDUE':
        return 'متأخر';

      case 'PENDING':
        return 'قيد الانتظار';

      default:
        return status;
    }
  }

  String _formatAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return amount.toInt().toString();
    }

    return amount.toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_monthName(date.month)} '
        '${date.year}';
  }

  String _formatMonth(DateTime date) {
    return '${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return months[month - 1];
  }

  String _paymentChannelText(String channel) {
    switch (channel.toUpperCase()) {
      case 'CARD':
        return 'بطاقة إلكترونية';

      case 'VODAFONE_CASH':
        return 'فودافون كاش';

      case 'CASH':
        return 'نقدي';

      default:
        return channel;
    }
  }
}