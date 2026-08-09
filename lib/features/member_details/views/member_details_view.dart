import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../presentation/view_model/member_details_cubit.dart';
import '../widgets/member_header.dart';
import '../widgets/member_tabs.dart';
import '../widgets/personal_info_card.dart';
import '../widgets/trust_card.dart';

class MemberDetailsView extends StatelessWidget {
  const MemberDetailsView({
    super.key,
    required this.memberId,
  });

  final String memberId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<MemberDetailsCubit, MemberDetailsState>(
            builder: (context, state) {
              if (state is MemberDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is MemberDetailsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is MemberDetailsSuccess) {
                final member = state.member;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      children: [
                        MemberHeader(member: member),

                        SizedBox(height: 24.h),

                        TrustCard(member: member),

                        SizedBox(height: 20.h),

                        MemberTabs(
                          member: member,
                          currentIndex: 0,
                        ),

                        SizedBox(height: 20.h),

                        PersonalInfoCard(member: member),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}