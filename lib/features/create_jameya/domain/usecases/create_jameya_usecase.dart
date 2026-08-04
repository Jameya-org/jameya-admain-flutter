import 'package:jameya/features/create_jameya/domain/entities/create_jameya_entity.dart';
import 'package:jameya/features/create_jameya/domain/repositories/create_jameya_repository.dart';

/// Single-purpose use case: create a new jameya.
class CreateJameyaUseCase {
  final CreateJameyaRepository _repository;

  const CreateJameyaUseCase(this._repository);

  /// Delegates to the repository. Throws on failure.
  Future<void> call(CreateJameyaEntity entity) =>
      _repository.createJameya(entity);
}
