import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ widgets/payment_summary_card.dart';
import '../ widgets/payments_list.dart';

import '../../../../core/utils/app_colors.dart';

import '../../member_details/models/member_details_model.dart';
import '../../member_details/widgets/member_header.dart';
import '../../member_details/widgets/member_tabs.dart';
import '../../member_details/widgets/trust_card.dart';

class MemberPaymentsView extends StatelessWidget {
  const MemberPaymentsView({
    super.key,
    required this.member,
  });

  final MemberDetailsModel member;

  @override
  Widget build(BuildContext context) {
    final installments = member.installments;
    debugPrint(
      '================ PAYMENTS DEBUG ================',
    );

    debugPrint(
      'MEMBER ID: ${member.id}',
    );

    debugPrint(
      'INSTALLMENTS LENGTH: ${installments.length}',
    );

    for (final installment in installments) {
      debugPrint(
        'Installment: '
            'id=${installment.id}, '
            'status=${installment.status}, '
            'amount=${installment.amount}, '
            'dueDate=${installment.dueDate}',
      );
    }

    debugPrint(
      '=================================================',
    );
    final total = installments.length;

    final paid = installments
        .where(
          (installment) =>
      installment.status.toUpperCase() ==
          'PAID',
    )
        .length;

    final overdue = installments
        .where(
          (installment) =>
      installment.status.toUpperCase() ==
          'OVERDUE',
    )
        .length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: ListView(
            physics:
            const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            children: [
              MemberHeader(
                member: member,
              ),

              SizedBox(height: 28.h),

              TrustCard(
                member: member,
              ),

              SizedBox(height: 14.h),

              MemberTabs(
                member: member,
                currentIndex: 2,
              ),

              SizedBox(height: 18.h),

              // =========================
              // Summary
              // =========================
              Row(
                children: [
                  Expanded(
                    child: PaymentSummaryCard(
                      title: 'الإجمالي',
                      value: total.toString(),
                      valueColor:
                      Colors.black,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: PaymentSummaryCard(
                      title: 'متأخر',
                      value:
                      overdue.toString(),
                      valueColor:
                      Colors.orange,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: PaymentSummaryCard(
                      title: 'مدفوع',
                      value:
                      paid.toString(),
                      valueColor:
                      AppColors.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // =========================
              // Payments
              // =========================
              PaymentsList(
                installments: installments,
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}