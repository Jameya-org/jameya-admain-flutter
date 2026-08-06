import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/tasks/data/models/overdue_payment_model.dart';

/// Single card for an overdue payment list item matching Screenshot 2 exactly
class OverduePaymentCard extends StatelessWidget {
  const OverduePaymentCard({super.key, required this.payment});

  final OverduePaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.kDelayDetailsView, extra: payment),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 23.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Red circle with exclamation mark ! (FAR RIGHT in RTL)
              Container(
                width: 22.w,
                height: 22.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53E3E),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '!',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 18.w),

              // 2. Member info (Name, Phone, Turn, Due Date)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.memberName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      payment.phone,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      payment.floor,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'تاريخ الاستحقاق ${payment.dueDate}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Amount + Status Badge + Chevron (FAR LEFT in RTL)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${_formatAmount(payment.amount)} ج.م',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: const Color(0xFFFFCCCC),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'متاخر ${payment.daysLate} ايام',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return amount.toString();
  }
}
