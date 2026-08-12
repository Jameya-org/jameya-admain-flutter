import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/utils/app_colors.dart';
import 'package:jameya_admin/core/utils/app_text_styles.dart';
import 'package:jameya_admin/core/widgets/error_state_view.dart';
import 'package:jameya_admin/features/tasks/data/models/expense_model.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_cubit.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_state.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExpensesCubit>()..fetchExpenses(),
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
              'المصروفات',
              style: AppTextStyles.appBarTitle,
            ),
          ),
          body: BlocBuilder<ExpensesCubit, ExpensesState>(
            builder: (context, state) {
              if (state is ExpensesLoading || state is ExpenseConfirming) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (state is ExpensesLoaded) {
                return _ExpensesBody(
                  expenses: state.expenses,
                  summary: state.summary,
                );
              }
              if (state is ExpensesError) {
                return ErrorStateView(
                  message: state.message,
                  onRetry: () => context.read<ExpensesCubit>().fetchExpenses(),
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

// ── Body with summary card + grouped list matching Screenshot 4 ────────────────
class _ExpensesBody extends StatelessWidget {
  const _ExpensesBody({required this.expenses, required this.summary});

  final List<ExpenseModel> expenses;
  final ExpensesSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    // Group expenses by date string
    final Map<String, List<ExpenseModel>> grouped = {};
    for (final e in expenses) {
      final key = _formatDateGroup(e.date);
      grouped.putIfAbsent(key, () => []).add(e);
    }
    final dateKeys = grouped.keys.toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── Summary Header Card (Screenshot 4 Top Box) ─────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
            child: _SummaryCard(summary: summary),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),

        // ── Grouped Expense Items ───────────────────────────────────────
        ...dateKeys.map((dateKey) {
          final items = grouped[dateKey]!;
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Group Label (RTL Start)
                  Text(
                    dateKey,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Expense cards for this date
                  ...items.map((e) => _ExpenseCard(expense: e)),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        }),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }

  String _formatDateGroup(String dateStr) {
    if (dateStr == 'اليوم' || dateStr == '1-8-2026') return dateStr;
    try {
      final dt = DateTime.parse(dateStr);
      final now = DateTime.now();
      if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
        return 'اليوم';
      }
      return '${dt.day}-${dt.month}-${dt.year}';
    } catch (_) {
      return dateStr;
    }
  }
}

// ── Summary Card (Screenshot 4 Top Card) ───────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});
  final ExpensesSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          // Right Column (RTL Start): عدد العمليات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'عدد العمليات',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  summary.operationsCount.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Vertical Divider
          Container(height: 44.h, width: 1, color: const Color(0xFFE2E8F0)),
          // Left Column (RTL End): اجمالي المبلغ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اجمالي المبلغ',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${_formatAmount(summary.totalAmount)} ج.م',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return amount.toString();
  }
}

// ── Expense Card (Screenshot 4 Item Card) ──────────────────────────────────────
class _ExpenseCard extends StatelessWidget {
  const _ExpenseCard({required this.expense});
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Right: Member Info (Name, Phone, Turn)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.memberName,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  expense.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: AppColors.textHint,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  expense.floor,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),

          // Left: Amount + "تأكيد الدفع" Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_formatAmount(expense.amount)}ج.م',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: expense.isConfirmed
                    ? null
                    : () => context.read<ExpensesCubit>().confirmExpense(
                        expense.id,
                      ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: expense.isConfirmed
                        ? const Color(0xFFCBD5E1)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'تأكيد الدفع',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return amount.toString();
  }
}
