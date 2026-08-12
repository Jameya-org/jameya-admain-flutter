import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/member_details_model.dart';

class MemberDetailsService {
  final Dio dio;

  MemberDetailsService(this.dio);

  Future<MemberDetailsModel> getMember(String id) async {
    final response = await dio.get('/admin/customers/$id');

    print(
      const JsonEncoder.withIndent('  ').convert(response.data),
    );

    return MemberDetailsModel.fromJson(
      response.data,
    );
  }
}