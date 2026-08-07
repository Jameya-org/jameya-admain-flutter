import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jameya_admin/features/tasks/data/models/expense_model.dart';
import 'package:jameya_admin/features/tasks/data/models/payment_review_model.dart';
import 'package:jameya_admin/features/tasks/data/repos/tasks_repo.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_state.dart';

// ── 1. Overdue Payments Cubit (الدفعات المتأخرة) ────────────────────────────
class OverduePaymentsCubit extends Cubit<OverduePaymentsState> {
  final TasksRepo _repo;

  OverduePaymentsCubit(this._repo) : super(OverduePaymentsInitial());

  Future<void> fetchOverduePayments({String? search}) async {
    emit(OverduePaymentsLoading());
    try {
      final payments = await _repo.getOverduePayments(search: search);
      emit(OverduePaymentsLoaded(payments));
    } catch (e) {
      emit(OverduePaymentsError(e.toString()));
    }
  }
}

// ── 2. Review Payments Cubit (مراجعة الدفعات) ─────────────────────────────────
class ReviewPaymentsCubit extends Cubit<ReviewPaymentsState> {
  final TasksRepo _repo;

  ReviewPaymentsCubit(this._repo) : super(ReviewPaymentsInitial());

  List<PaymentReviewModel> _allReviews = [];
  String _currentTab = 'all';
  String _searchQuery = '';

  Future<void> fetchPaymentProofs({String? search}) async {
    if (search != null) {
      _searchQuery = search;
    }
    emit(ReviewPaymentsLoading());
    try {
      final all = await _repo.getPaymentProofs(search: _searchQuery);
      _allReviews = all;
      _emitFiltered();
    } catch (e) {
      emit(ReviewPaymentsError(e.toString()));
    }
  }

  void changeTab(String tab) {
    _currentTab = tab;
    _emitFiltered();
  }

  void _emitFiltered() {
    List<PaymentReviewModel> filtered;

    if (_currentTab == 'success') {
      filtered = _allReviews.where((p) => p.isSuccess).toList();
    } else if (_currentTab == 'failed') {
      filtered = _allReviews.where((p) => p.status == 'failed').toList();
    } else {
      filtered = List.from(_allReviews);
    }

    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      filtered = filtered.where((p) {
        return p.memberName.toLowerCase().contains(q) ||
            p.phone.contains(q) ||
            p.floor.toLowerCase().contains(q) ||
            p.amount.toString().contains(q);
      }).toList();
    }

    emit(
      ReviewPaymentsLoaded(
        all: List.from(_allReviews),
        filtered: filtered,
        activeTab: _currentTab,
      ),
    );
  }

  Future<void> approvePayment(String paymentId) async {
    emit(ReviewPaymentApproving());
    try {
      await _repo.approvePayment(paymentId);
      emit(ReviewPaymentApproved());
      await fetchPaymentProofs();
    } catch (e) {
      emit(ReviewPaymentsError(e.toString()));
    }
  }
}

// ── 3. Expenses Cubit (المصروفات) ─────────────────────────────────────────────
class ExpensesCubit extends Cubit<ExpensesState> {
  final TasksRepo _repo;

  ExpensesCubit(this._repo) : super(ExpensesInitial());

  Future<void> fetchExpenses() async {
    emit(ExpensesLoading());
    try {
      final expenses = await _repo.getExpenses();
      final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);
      emit(
        ExpensesLoaded(
          expenses: expenses,
          summary: ExpensesSummaryModel(
            operationsCount: expenses.length,
            totalAmount: total,
          ),
        ),
      );
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }

  Future<void> confirmExpense(String expenseId) async {
    final previousState = state;
    emit(ExpenseConfirming());
    try {
      await _repo.confirmExpense(expenseId);
      emit(ExpenseConfirmed(expenseId));
      await fetchExpenses();
    } catch (e) {
      if (previousState is ExpensesLoaded) {
        emit(previousState);
      }
      emit(ExpensesError(e.toString()));
    }
  }
}
