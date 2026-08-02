import 'package:get_it/get_it.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/localization/cubit/localization_cubit.dart';
import 'package:jameya/core/services/api_service.dart';
import 'package:jameya/features/home/data/repos/home_repo.dart';
import 'package:jameya/features/home/presentation/manager/home_cubit/home_cubit.dart';

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

  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<ApiService>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
}
