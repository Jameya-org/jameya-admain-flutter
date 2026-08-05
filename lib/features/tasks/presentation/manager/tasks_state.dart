import 'package:jameya/features/tasks/data/models/overdue_payment_model.dart';
import 'package:jameya/features/tasks/data/models/payment_review_model.dart';
import 'package:jameya/features/tasks/data/models/expense_model.dart';

// ── Overdue Payments States ───────────────────────────────────────────────────
abstract class OverduePaymentsState {}

class OverduePaymentsInitial extends OverduePaymentsState {}

class OverduePaymentsLoading extends OverduePaymentsState {}

class OverduePaymentsLoaded extends OverduePaymentsState {
  final List<OverduePaymentModel> payments;
  OverduePaymentsLoaded(this.payments);
}

class OverduePaymentsError extends OverduePaymentsState {
  final String message;
  OverduePaymentsError(this.message);
}

// ── Review Payments States ────────────────────────────────────────────────────
abstract class ReviewPaymentsState {}

class ReviewPaymentsInitial extends ReviewPaymentsState {}

class ReviewPaymentsLoading extends ReviewPaymentsState {}

class ReviewPaymentsLoaded extends ReviewPaymentsState {
  final List<PaymentReviewModel> all;
  final List<PaymentReviewModel> filtered;
  final String activeTab; // 'all' | 'success' | 'failed'
  ReviewPaymentsLoaded({
    required this.all,
    required this.filtered,
    required this.activeTab,
  });
}

class ReviewPaymentsError extends ReviewPaymentsState {
  final String message;
  ReviewPaymentsError(this.message);
}

class ReviewPaymentApproving extends ReviewPaymentsState {}

class ReviewPaymentApproved extends ReviewPaymentsState {}

// ── Expenses States ───────────────────────────────────────────────────────────
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<ExpenseModel> expenses;
  final ExpensesSummaryModel summary;
  ExpensesLoaded({required this.expenses, required this.summary});
}

class ExpensesError extends ExpensesState {
  final String message;
  ExpensesError(this.message);
}

class ExpenseConfirming extends ExpensesState {}

class ExpenseConfirmed extends ExpensesState {
  final String expenseId;
  ExpenseConfirmed(this.expenseId);
}
