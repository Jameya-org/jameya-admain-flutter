import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/services/services_locator.dart';
import '../models/membership_model.dart';

class MembershipService {
  final Dio dio = getIt<Dio>();

  Future<List<MembershipModel>> getMemberships(
      String customerId,
      ) async {
    final response = await dio.get(
      '/admin/memberships',
    );

    debugPrint('================ MEMBERSHIPS API ================');
    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('CUSTOMER ID: $customerId');
    debugPrint('RESPONSE: ${response.data}');
    debugPrint('==================================================');

    final List data = response.data['data'] ?? [];

    debugPrint('DATA LENGTH: ${data.length}');

    for (final item in data) {
      debugPrint(
        'Membership customerId: ${item['customerId']}',
      );
    }

    final memberships = data
        .map(
          (e) => MembershipModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .where(
          (membership) =>
      membership.customerId == customerId,
    )
        .toList();

    debugPrint(
      'FILTERED MEMBERSHIPS: ${memberships.length}',
    );

    return memberships;
  }
}