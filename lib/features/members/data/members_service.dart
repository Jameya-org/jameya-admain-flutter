import 'package:dio/dio.dart';

import '../ models/member_model.dart';

class MembersService {
  final Dio dio;

  MembersService(this.dio);

  Future<List<MemberModel>> getMembers({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
    String? kycStatus,
  }) async {
    final response = await dio.get(
      '/admin/customers',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null && status.isNotEmpty) 'status': status,
        if (kycStatus != null && kycStatus.isNotEmpty)
          'kycStatus': kycStatus,
      },
    );

    final List data = response.data['data'];

    return data
        .map((e) => MemberModel.fromJson(e))
        .toList();
  }
}