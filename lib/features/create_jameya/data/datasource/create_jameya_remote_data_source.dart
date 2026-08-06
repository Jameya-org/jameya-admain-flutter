import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_request_model.dart';
import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_response_model.dart';

/// Contract for remote API operations related to jameya creation.
abstract class CreateJameyaRemoteDataSource {
  Future<CreateJameyaResponseModel> createJameya(
    CreateJameyaRequestModel request,
  );
}
