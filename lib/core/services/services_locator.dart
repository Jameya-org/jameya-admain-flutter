import 'package:get_it/get_it.dart';
import 'package:jameya/core/api/api_services.dart';
import 'package:jameya/core/api/api_services_implementation.dart';
import 'package:jameya/core/api/app_interceptors.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/localization/cubit/localization_cubit.dart';
import 'package:jameya/features/home/data/repos/home_repo.dart';
import 'package:jameya/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:jameya/features/society_management/data/repos/society_repo.dart';
import 'package:jameya/features/society_management/presentation/viewmodel/society_cubit.dart';
import 'package:jameya/features/tasks/data/repos/tasks_repo.dart';
import 'package:jameya/features/tasks/presentation/manager/tasks_cubit.dart';

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

  // Network & API Services
  getIt.registerSingleton<AppInterceptors>(AppInterceptors());
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServicesImplementation(getIt<AppInterceptors>()),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton<SocietyRepo>(() => SocietyRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton<TasksRepo>(() => TasksRepo(getIt<ApiServices>()));

  // Cubits / Blocs
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  getIt.registerFactory<SocietyCubit>(() => SocietyCubit(getIt<SocietyRepo>()));
  getIt.registerFactory<OverduePaymentsCubit>(() => OverduePaymentsCubit(getIt<TasksRepo>()));
  getIt.registerFactory<ReviewPaymentsCubit>(() => ReviewPaymentsCubit(getIt<TasksRepo>()));
  getIt.registerFactory<ExpensesCubit>(() => ExpensesCubit(getIt<TasksRepo>()));
}

