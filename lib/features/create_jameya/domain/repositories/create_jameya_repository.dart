import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_response_model.dart';
import 'package:jameya_admin/features/create_jameya/domain/entities/create_jameya_entity.dart';

/// Abstract contract that the data layer must implement.
abstract class CreateJameyaRepository {
  /// Sends a request to persist the new jameya in the backend.
  /// Returns the created jameya (including its ID).
  Future<CreateJameyaResponseModel> createJameya(CreateJameyaEntity entity);
}
