import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/localization/cubit/localization_cubit.dart';

import '../../features/auth/data/services/admin_auth_service.dart';
import '../../features/auth/presentation/view_model/auth_cubit.dart';
import '../network/dio_interceptor.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();

  getIt.registerSingleton<CacheHelper>(cacheHelper);

  getIt.registerLazySingleton<LocaleCubit>(
        () => LocaleCubit(getIt<CacheHelper>()),
  );

  // Dio

  getIt.registerLazySingleton<Dio>(
        () {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://jameya-backend.onrender.com',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      dio.interceptors.add(
        AppInterceptor(),
      );

      return dio;
    },
  );
  // AdminAuthService

  getIt.registerLazySingleton<AdminAuthService>(
        () => AdminAuthService(getIt<Dio>()),
  );
  getIt.registerFactory<AuthCubit>(
        () => AuthCubit(),
  );
}