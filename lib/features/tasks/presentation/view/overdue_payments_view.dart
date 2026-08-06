import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_cubit.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_state.dart';
import 'package:jameya_admin/features/tasks/presentation/view/widgets/overdue_payment_card.dart';
import 'package:jameya_admin/features/tasks/presentation/view/widgets/tasks_search_bar.dart';

class OverduePaymentsView extends StatelessWidget {
  const OverduePaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OverduePaymentsCubit>()..fetchOverduePayments(),
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
              'الدفعات المتاخرة',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          body: BlocBuilder<OverduePaymentsCubit, OverduePaymentsState>(
            builder: (context, state) {
              return Column(
                children: [
                  // ── Search Bar ────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                    child: TasksSearchBar(
                      onChanged: (query) => context
                          .read<OverduePaymentsCubit>()
                          .fetchOverduePayments(search: query),
                    ),
                  ),
                  SizedBox(height: 23.h),

                  // ── List ──────────────────────────────────────────────────
                  Expanded(child: _buildBody(context, state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, OverduePaymentsState state) {
    if (state is OverduePaymentsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (state is OverduePaymentsLoaded) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.payments.length,
        itemBuilder: (_, index) =>
            OverduePaymentCard(payment: state.payments[index]),
      );
    }
    return const SizedBox.shrink();
  }
}
