import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/localization/cubit/localization_cubit.dart';
import 'package:jameya/core/services/dio_factory.dart';
import 'package:jameya/features/create_jameya/data/datasource/create_jameya_remote_data_source.dart';
import 'package:jameya/features/create_jameya/data/datasource/create_jameya_remote_data_source_impl.dart';
import 'package:jameya/features/create_jameya/data/repositories/create_jameya_repository_impl.dart';
import 'package:jameya/features/create_jameya/domain/repositories/create_jameya_repository.dart';
import 'package:jameya/features/create_jameya/domain/usecases/create_jameya_usecase.dart';
import 'package:jameya/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';

// Global GetIt instance for dependency injection
final getIt = GetIt.instance;

// Registers all app services/dependencies before the app runs
Future<void> setupServiceLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  // Register CacheHelper as a singleton so the same instance is shared app-wide
  getIt.registerSingleton<CacheHelper>(cacheHelper);

  // LocaleCubit is lazy — created only when first requested
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<CacheHelper>()),
  );

  // ── Dio HTTP client ────────────────────────────────────────────────────────
  // Registered as a lazy singleton so the same configured instance is reused
  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  // ── Create Jameya ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<CreateJameyaRemoteDataSource>(
    () => CreateJameyaRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CreateJameyaRepository>(
    () => CreateJameyaRepositoryImpl(getIt<CreateJameyaRemoteDataSource>()),
  );

  getIt.registerLazySingleton<CreateJameyaUseCase>(
    () => CreateJameyaUseCase(getIt<CreateJameyaRepository>()),
  );

  // Factory: a new cubit is created each time the route is pushed
  getIt.registerFactory<CreateJameyaCubit>(
    () => CreateJameyaCubit(getIt<CreateJameyaUseCase>()),
  );
}
