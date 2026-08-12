import 'package:jameya_admin/features/create_jameya/data/datasource/create_jameya_remote_data_source.dart';
import 'package:jameya_admin/features/create_jameya/data/models/create_jameya_request_model.dart';
import 'package:jameya_admin/features/create_jameya/domain/entities/create_jameya_entity.dart';
import 'package:jameya_admin/features/create_jameya/domain/repositories/create_jameya_repository.dart';

/// Bridges the domain layer to the remote data source.
class CreateJameyaRepositoryImpl implements CreateJameyaRepository {
  final CreateJameyaRemoteDataSource _remoteDataSource;

  const CreateJameyaRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> createJameya(CreateJameyaEntity entity) async {
    final request = CreateJameyaRequestModel.fromEntity(entity);
    await _remoteDataSource.createJameya(request);
  }
}
