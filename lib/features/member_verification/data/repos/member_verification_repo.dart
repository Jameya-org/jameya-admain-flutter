import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/end_points.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';

class MemberVerificationRepo {
  final ApiServices apiServices;

  MemberVerificationRepo(this.apiServices);

  Future<List<MemberVerificationModel>> getPendingMembers() async {
    try {
      final response = await apiServices.get(endPoint: EndPoints.pendingKycDocs);
      final data = response.data;
      if (data is List && data.isNotEmpty) {
        final Map<String, Map<String, dynamic>> grouped = {};
        for (final item in data) {
          if (item is Map<String, dynamic>) {
            final customerId = item['customerId']?.toString() ?? item['id']?.toString() ?? '';
            if (customerId.isNotEmpty) {
              if (!grouped.containsKey(customerId)) {
                grouped[customerId] = {
                  'customer': item['customer'] ?? item,
                  'id': customerId,
                  'documents': [item],
                };
              } else {
                (grouped[customerId]!['documents'] as List).add(item);
              }
            }
          }
        }
        return grouped.values
            .map((item) => MemberVerificationModel.fromJson(item))
            .toList();
      } else if (data is Map<String, dynamic> && data['data'] is List && (data['data'] as List).isNotEmpty) {
        final list = data['data'] as List;
        return list
            .map((item) => MemberVerificationModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // If pending-documents returns empty list [], try fetching customers
      try {
        final customersResponse = await apiServices.get(endPoint: EndPoints.adminCustomers);
        final customersData = customersResponse.data;
        List rawList = [];
        if (customersData is List) {
          rawList = customersData;
        } else if (customersData is Map<String, dynamic> && customersData['data'] is List) {
          rawList = customersData['data'] as List;
        }
        if (rawList.isNotEmpty) {
          // Only show customers who still need KYC review (not already APPROVED/REJECTED)
          final pendingRaw = rawList.where((item) {
            if (item is Map<String, dynamic>) {
              final identityProfile = item['identityProfile'];
              final kycStatus = identityProfile is Map
                  ? identityProfile['kycStatus']?.toString()
                  : item['kycStatus']?.toString();
              return kycStatus == 'PENDING' || kycStatus == 'UNDER_REVIEW';
            }
            return false;
          }).toList();
          final parsed = pendingRaw
              .map((item) => MemberVerificationModel.fromJson(item as Map<String, dynamic>))
              .toList();
          if (parsed.isNotEmpty) return parsed;
        }
      } catch (_) {}

      // Fallback to empty list if no pending documents or customers returned
      return [];
    } catch (e) {
      // Fallback to empty list if endpoint fails
      return [];
    }
  }

  Future<void> reviewDocument({
    required String documentId,
    required String status, // APPROVED or REJECTED
    String? rejectionReason,
  }) async {
    final Map<String, dynamic> data = {'status': status};
    if (status == 'REJECTED' && rejectionReason != null && rejectionReason.isNotEmpty) {
      data['rejectionReason'] = rejectionReason;
    }

    await apiServices.patch(
      endPoint: EndPoints.reviewKycDocument(documentId),
      data: data,
    );
  }

  Future<void> submitEligibility({
    required String customerId,
    required double maxMonthlyInstallmentLimit,
  }) async {
    await apiServices.post(
      endPoint: EndPoints.kycEligibility,
      data: {
        'customerId': customerId,
        'participationLimit': maxMonthlyInstallmentLimit,
        'status': 'ELIGIBLE',
        'policyVersion': 'v1.0-12m',
        'expiresAt': DateTime.now().add(const Duration(days: 365)).toIso8601String(),
        'reason': 'Approved by admin',
      },
    );
  }

  List<MemberVerificationModel> _getMockPendingMembers() {
    return List.generate(
      5,
      (index) => MemberVerificationModel(
        id: '${index + 1}',
        name: 'محمد احمد علي',
        phone: '01234567890',
        email: 'ex@gmail.com',
        status: 'قيد الانتظار',
        documents: [
          MemberDocumentModel(
            id: 'doc_1',
            title: 'صورة البطاقة الشخصية',
            imageUrl: 'https://placeholder.co/600x400/png',
          ),
          MemberDocumentModel(
            id: 'doc_2',
            title: 'المرتب',
            imageUrl: 'https://placeholder.co/600x400/png',
          ),
        ],
      ),
    );
  }
}
