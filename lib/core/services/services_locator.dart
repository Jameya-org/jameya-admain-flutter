import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jameya/core/api/api_services.dart';
import 'package:jameya/core/api/api_services_implementation.dart';
import 'package:jameya/core/api/app_interceptors.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/localization/cubit/localization_cubit.dart';
import 'package:jameya/core/services/dio_factory.dart';
import 'package:jameya/features/auth/data/services/admin_auth_service.dart';
import 'package:jameya/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:jameya/features/create_jameya/data/datasource/create_jameya_remote_data_source.dart';
import 'package:jameya/features/create_jameya/data/datasource/create_jameya_remote_data_source_impl.dart';
import 'package:jameya/features/create_jameya/data/repositories/create_jameya_repository_impl.dart';
import 'package:jameya/features/create_jameya/domain/repositories/create_jameya_repository.dart';
import 'package:jameya/features/create_jameya/domain/usecases/create_jameya_usecase.dart';
import 'package:jameya/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya/features/home/data/repos/home_repo.dart';
import 'package:jameya/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:jameya/features/society_management/data/repos/society_repo.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_cubit.dart';
import 'package:jameya/features/tasks/data/repos/tasks_repo.dart';
import 'package:jameya/features/tasks/presentation/manager/tasks_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  getIt.registerSingleton<CacheHelper>(cacheHelper);

  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<CacheHelper>()),
  );

  // ── Dio HTTP client ────────────────────────────────────────────────────────
  // Registered as a lazy singleton so the same configured instance is reused
  // (attaches the Bearer token via DioFactory's auth interceptor).
  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  // ── Network & API Services (Tasks/Home/Society) ───────────────────────
  getIt.registerSingleton<AppInterceptors>(AppInterceptors());
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServicesImplementation(getIt<AppInterceptors>()),
  );

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

  // ── Auth ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AdminAuthService>(
    () => AdminAuthService(getIt<Dio>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(),
  );

  // ── Repositories ──────────────────────────────────────────────────────
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton<SocietyRepo>(
    () => SocietyRepo(getIt<ApiServices>()),
  );
  getIt.registerLazySingleton<TasksRepo>(
    () => TasksRepo(getIt<ApiServices>()),
  );

  // ── Cubits / Blocs ────────────────────────────────────────────────────
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  getIt.registerFactory<SocietyCubit>(
    () => SocietyCubit(getIt<SocietyRepo>()),
  );
  getIt.registerFactory<OverduePaymentsCubit>(
    () => OverduePaymentsCubit(getIt<TasksRepo>()),
  );
  getIt.registerFactory<ReviewPaymentsCubit>(
    () => ReviewPaymentsCubit(getIt<TasksRepo>()),
  );
  getIt.registerFactory<ExpensesCubit>(
    () => ExpensesCubit(getIt<TasksRepo>()),
  );
}