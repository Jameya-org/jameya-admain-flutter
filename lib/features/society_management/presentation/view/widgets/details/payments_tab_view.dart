import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/features/society_management/presentation/viewmodel/society_details_cubit.dart';
import 'package:jameya_admin/features/society_management/presentation/viewmodel/society_details_state.dart';

import 'payment_metric_badge.dart';
import 'payment_timeline_item.dart';

class PaymentsTabView extends StatelessWidget {
  const PaymentsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: BlocBuilder<SocietyDetailsCubit, SocietyDetailsState>(
        builder: (context, state) {
          if (state is SocietyDetailsLoaded) {
            return Column(
              children: [
                PaymentMetricBadgesRow(payments: state.payments),
                SizedBox(height: 14.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      return PaymentTimelineItem(
                        payment: state.payments[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
