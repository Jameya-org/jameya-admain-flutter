import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/tasks/data/models/overdue_payment_model.dart';

/// تفاصيل التأخير - Screenshot 1
class DelayDetailsView extends StatelessWidget {
  const DelayDetailsView({super.key, required this.payment});

  final OverduePaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.primary,
              size: 28.sp,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            'تفاصيل التأخير',
            style: AppTextStyles.appBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              // ── Member Profile Card ────────────────────────────────────
              _MemberCard(payment: payment),
              SizedBox(height: 16.h),

              // ── Details Table Card ─────────────────────────────────────
              _DetailsCard(payment: payment),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Member Card (Screenshot 1 Top Card with Profile Image) ────────────────────
class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.payment});
  final OverduePaymentModel payment;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = payment.avatarUrl ?? 'https://i.pravatar.cc/150?img=60';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Avatar Image on the RIGHT in RTL
          ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: Container(
              width: 56.w,
              height: 56.h,
              color: const Color(0xFFCBD5E1),
              child: Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Icon(Icons.person, size: 34.sp, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 30.w),

          // Member Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.memberName.isNotEmpty
                      ? payment.memberName
                      : 'محمد احمد علي',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  payment.email.isNotEmpty ? payment.email : 'ex@gmail.com',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.textHint,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  payment.phone.isNotEmpty ? payment.phone : '01234567890',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Details Card (Screenshot 1 Bottom Card) ────────────────────────────────────
class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.payment});
  final OverduePaymentModel payment;

  @override
  Widget build(BuildContext context) {
    final amountText = payment.amount > 0
        ? _formatAmount(payment.amount)
        : '1,000';
    final dueDateText = payment.dueDate.isNotEmpty
        ? payment.dueDate
        : '1-7-2026';
    final daysLateText = payment.daysLate > 0
        ? payment.daysLate.toString()
        : '3';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 43.w, vertical: 41.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          _DetailRow(
            label: 'المبلغ المطلوب',
            value: '$amountText ج.م',
            valueColor: AppColors.primary,
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _DetailRow(
            label: 'تاريخ الاستحقاق',
            value: dueDateText,
            valueColor: AppColors.primary,
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _DetailRow(
            label: 'تاريخ اليوم',
            value: '4-7-2026',
            valueColor: AppColors.primary,
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _DetailRow(
            label: 'عدد ايام التأخير',
            value: daysLateText,
            valueColor: AppColors.primary,
          ),
        ],
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label on the RIGHT in RTL
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textHint,
            ),
          ),
          // Value on the LEFT in RTL
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
