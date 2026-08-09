import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../ widgets/member_card.dart';
import '../ widgets/members_search_field.dart';
import '../ widgets/status_filter.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../presentation/view_model/members_cubit.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MembersCubit>()..getMembers(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primary,
                            size: 24.sp,
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              'إدارة الأعضاء',
                              style: AppTextStyles.headline.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 48.w),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    const MembersSearchField(),

                    SizedBox(height: 16.h),

                    const StatusFilter(),

                    SizedBox(height: 20.h),

                    BlocBuilder<MembersCubit, MembersState>(
                      builder: (context, state) {
                        if (state is MembersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is MembersFailure) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        if (state is MembersSuccess) {
                          if (state.members.isEmpty) {
                            return const Center(
                              child: Text('لا يوجد أعضاء'),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount: state.members.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: 16.h),
                            itemBuilder: (_, index) {
                              final member = state.members[index];

                             return MemberCard(
                                id: member.id,
                                name: member.name,
                                phone: member.phone,
                                status: member.kycStatus,
                              );
                            },
                          );
                        }

                        return const SizedBox();
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}