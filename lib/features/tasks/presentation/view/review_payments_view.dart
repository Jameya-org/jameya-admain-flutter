import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/core/widgets/error_state_view.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_cubit.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_state.dart';
import 'package:jameya_admin/features/tasks/presentation/view/widgets/payment_review_card.dart';
import 'package:jameya_admin/features/tasks/presentation/view/widgets/payment_review_tab_bar.dart';
import 'package:jameya_admin/features/tasks/presentation/view/widgets/tasks_search_bar.dart';

class ReviewPaymentsView extends StatelessWidget {
  const ReviewPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReviewPaymentsCubit>()..fetchPaymentProofs(),
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
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text(
              'مراجعة الدفعات',
              style: AppTextStyles.appBarTitle,
            ),
          ),
          body: BlocBuilder<ReviewPaymentsCubit, ReviewPaymentsState>(
            builder: (context, state) {
              final activeTab = state is ReviewPaymentsLoaded
                  ? state.activeTab
                  : 'all';

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                    child: Column(
                      children: [
                        // ── Search Bar ──────────────────────────────────
                        TasksSearchBar(
                          onChanged: (q) => context
                              .read<ReviewPaymentsCubit>()
                              .fetchPaymentProofs(search: q),
                        ),
                        SizedBox(height: 23.h),
                        // ── Tab Bar (الكل - ناجحة - فاشلة) ──────────────
                        PaymentReviewTabBar(
                          activeTab: activeTab,
                          onTabChanged: (tab) => context
                              .read<ReviewPaymentsCubit>()
                              .changeTab(tab),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ── List ──────────────────────────────────────────────
                  Expanded(child: _buildBody(context, state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ReviewPaymentsState state) {
    if (state is ReviewPaymentsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (state is ReviewPaymentsLoaded) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.filtered.length,
        itemBuilder: (_, i) => PaymentReviewCard(payment: state.filtered[i]),
      );
    }
    if (state is ReviewPaymentsError) {
      return ErrorStateView(
        message: state.message,
        onRetry: () => context.read<ReviewPaymentsCubit>().fetchPaymentProofs(),
      );
    }
    return const SizedBox.shrink();
  }
}
