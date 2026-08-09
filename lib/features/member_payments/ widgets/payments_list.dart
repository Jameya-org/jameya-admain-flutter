import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../member_details/models/member_details_model.dart';
import 'payment_card.dart';

class PaymentsList extends StatelessWidget {
  const PaymentsList({
    super.key,
    required this.installments,
  });

  final List<InstallmentModel> installments;

  @override
  Widget build(BuildContext context) {
    if (installments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            'لا توجد مدفوعات',
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: installments.length,
      separatorBuilder: (_, __) => SizedBox(height: 14.h),
      itemBuilder: (_, index) {
        final installment = installments[index];

        return PaymentCard(
          installment: installment,
        );
      },
    );
  }
}