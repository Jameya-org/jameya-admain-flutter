import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/tasks/data/models/payment_review_model.dart';

/// Single card for payment review list item matching Screenshot 3
class PaymentReviewCard extends StatelessWidget {
  const PaymentReviewCard({super.key, required this.payment});

  final PaymentReviewModel payment;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Right: Member Info (Name, Phone, Turn, Time Ago)
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
                    'منذ ${payment.timeAgo}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            // Left: Amount + Status Pill Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  '${_formatAmount(payment.amount)} ج.م',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 6.h),
                _StatusBadge(payment: payment),
              ],
            ),
          ],
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

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.payment});
  final PaymentReviewModel payment;

  @override
  Widget build(BuildContext context) {
    final (String label, Color bg, Color fg) = switch (payment.status) {
      'success' => (
          'ناجحة',
          const Color(0xFF9CEEBA),
          const Color(0xFF166534),
        ),
      'failed' => (
          'فاشلة',
          const Color(0xFFFBB3B3),
          const Color(0xFF991B1B),
        ),
      _ => (
          'معلق',
          const Color(0xFFFDE68A),
          const Color(0xFF92400E),
        ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}
