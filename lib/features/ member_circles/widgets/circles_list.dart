import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/membership_model.dart';
import 'circle_card.dart';

class CirclesList extends StatelessWidget {
  const CirclesList({
    super.key,
    required this.memberships,
  });

  final List<MembershipModel> memberships;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: memberships.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: 16.h),
      itemBuilder: (_, index) {
        final membership = memberships[index];

        return CircleCard(
          title:
          'دائرة ${membership.circle.durationMonths} شهر',
          amount:
          '${membership.circle.contributionAmount} ج.م / شهر',
          role:
          'الدور: #${membership.payoutPosition}',
          status:
          membership.status == 'ACTIVE'
              ? 'نشطة'
              : 'منتهية',
        );
      },
    );
  }
}