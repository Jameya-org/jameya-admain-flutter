import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/member_details_model.dart';

class MemberDetailsService {
  final Dio dio;

  MemberDetailsService(this.dio);

  Future<MemberDetailsModel> getMember(String id) async {
    final response = await dio.get('/admin/customers/$id');

    print(
      const JsonEncoder.withIndent('  ').convert(response.data),
    );
    debugPrint(
      'MEMBERSHIPS FROM CUSTOMER API: '
          '${(response.data['memberships'] as List?)?.length ?? 0}',
    );
    return MemberDetailsModel.fromJson(
      response.data,
    );
  }
}