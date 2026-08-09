import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_cubit.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_state.dart';
import 'package:jameya_admin/features/member_verification/presentation/widgets/member_verification_card.dart';

class MemberVerificationListView extends StatelessWidget {
  const MemberVerificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MemberVerificationCubit>()..fetchPendingMembers(),
      child: Directionality(
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
              onPressed: () => context.pop(),
            ),
            title: Text('توثيق الاعضاء', style: AppTextStyles.appBarTitle),
          ),
          body: BlocBuilder<MemberVerificationCubit, MemberVerificationState>(
            builder: (context, state) {
              if (state is MemberVerificationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MemberVerificationError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                );
              } else if (state is MemberVerificationLoaded) {
                final members = state.members;
                if (members.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد طلبات توثيق حالياً',
                      style: AppTextStyles.caption.copyWith(fontSize: 14.sp),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return MemberVerificationCard(
                      member: member,
                      onTap: () {
                        context.push(
                          AppRoutes.kMemberVerificationDetailView,
                          extra: member,
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
