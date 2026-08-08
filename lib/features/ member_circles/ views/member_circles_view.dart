import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../member_details/models/member_details_model.dart';
import '../../member_details/widgets/member_header.dart';
import '../../member_details/widgets/member_tabs.dart';
import '../../member_details/widgets/trust_card.dart';
import '../presentation/view_model/member_circles_cubit.dart';
import '../widgets/circles_list.dart';

class MemberCirclesView extends StatelessWidget {
  const MemberCirclesView({
    super.key,
    required this.member,
  });

  final MemberDetailsModel member;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MemberCirclesCubit>()
        ..getMemberships(member.id),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: BlocBuilder<
                  MemberCirclesCubit,
                  MemberCirclesState>(
                builder: (context, state) {
                  if (state is MemberCirclesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MemberCirclesFailure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (state is MemberCirclesSuccess) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
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

                        SizedBox(height: 20.h),

                        MemberTabs(
                          member: member,
                          currentIndex: 1,
                        ),

                        SizedBox(height: 20.h),

                        if (state.memberships.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                'لا توجد دوائر لهذا العضو',
                              ),
                            ),
                          )
                        else
                          CirclesList(
                            memberships: state.memberships,
                          ),

                        SizedBox(height: 30.h),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}