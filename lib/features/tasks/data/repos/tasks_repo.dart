import 'package:dio/dio.dart';
import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/core/errors/failures.dart';
import 'package:jameya_admin/features/tasks/data/models/expense_model.dart';
import 'package:jameya_admin/features/tasks/data/models/overdue_payment_model.dart';
import 'package:jameya_admin/features/tasks/data/models/payment_review_model.dart';

class TasksRepo {
  final ApiServices _apiServices;

  TasksRepo(this._apiServices);

  // ── 1. GET /admin/installments?status=OVERDUE ─────────────────────────────
  Future<List<OverduePaymentModel>> getOverduePayments({String? search}) async {
    try {
      final response = await _apiServices.get(
        endPoint: EndPoints.adminInstallments,
        queryParameters: {
          'status': 'OVERDUE',
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );

      final dynamic resData = response.data;
      List<dynamic> dataList = [];
      if (resData is List) {
        dataList = resData;
      } else if (resData is Map) {
        if (resData['data'] is List) {
          dataList = resData['data'];
        } else if (resData['data'] is Map) {
          final inner = resData['data'] as Map;
          dataList = inner['installments'] ?? inner['items'] ?? inner['data'] ?? inner.values.firstWhere((v) => v is List, orElse: () => []);
        } else if (resData['installments'] is List) {
          dataList = resData['installments'];
        } else if (resData['items'] is List) {
          dataList = resData['items'];
        }
      }

      final List<OverduePaymentModel> result = [];
      for (var e in dataList) {
        try {
          if (e is Map) {
            result.add(OverduePaymentModel.fromJson(Map<String, dynamic>.from(e)));
          }
        } catch (err) {
          // Ignore parsing errors for individual items to avoid crashing the whole list
        }
      }
      return result;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }

  // ── 2. GET /admin/transactions & /admin/payment-proofs for Payment Review ─
  Future<List<PaymentReviewModel>> getPaymentProofs({
    String? search,
    String? status,
  }) async {
    try {
      final List<PaymentReviewModel> result = [];

      // Fetch transactions (contains all collection & payment review items)
      try {
        final txResponse = await _apiServices.get(
          endPoint: EndPoints.transactions,
          queryParameters: {
            if (search != null && search.isNotEmpty) 'search': search,
          },
        );
        final dynamic txData = txResponse.data;
        final List<dynamic> txList = txData is List
            ? txData
            : (txData is Map && txData.containsKey('data')
                  ? txData['data']
                  : []);
        result.addAll(txList.map((e) => PaymentReviewModel.fromJson(e)));
      } catch (_) {}

      // Fetch payment proofs
      try {
        final proofResponse = await _apiServices.get(
          endPoint: EndPoints.paymentProofs,
          queryParameters: {
            if (search != null && search.isNotEmpty) 'search': search,
          },
        );
        final dynamic proofData = proofResponse.data;
        final List<dynamic> proofList = proofData is List
            ? proofData
            : (proofData is Map && proofData.containsKey('data')
                  ? proofData['data']
                  : []);
        final proofs = proofList
            .map((e) => PaymentReviewModel.fromJson(e))
            .toList();

        final existingIds = result.map((r) => r.id).toSet();
        for (final p in proofs) {
          if (!existingIds.contains(p.id)) {
            result.add(p);
          }
        }
      } catch (_) {}

      return result;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }

  // ── 3. PATCH /admin/payment-proofs/{id}/review ───────────────────────────
  Future<void> approvePayment(String paymentId) async {
    try {
      await _apiServices.patch(
        endPoint: '${EndPoints.paymentProofs}/$paymentId/review',
        data: {'status': 'APPROVED'},
      );
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }

  // ── 4. GET /admin/transactions ────────────────────────────────────────────
  Future<List<ExpenseModel>> getExpenses() async {
    try {
      final response = await _apiServices.get(endPoint: EndPoints.transactions);

      final dynamic resData = response.data;
      final List<dynamic> data = resData is List
          ? resData
          : (resData is Map && resData.containsKey('data')
                ? resData['data']
                : []);

      return data.map((e) => ExpenseModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }

  // ── 5. PATCH /admin/transactions/{id} ──────────────────────────────────────
  Future<void> confirmExpense(String expenseId) async {
    try {
      await _apiServices.patch(
        endPoint: '${EndPoints.transactions}/$expenseId',
        data: {'status': 'SETTLED'},
      );
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e).error;
    } catch (e) {
      throw ServerFailure(e.toString()).error;
    }
  }
}
