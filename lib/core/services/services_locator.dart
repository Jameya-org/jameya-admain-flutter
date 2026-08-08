import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/ member_circles/data/membership_service.dart';
import '../../features/ member_circles/presentation/view_model/member_circles_cubit.dart';
import '../../features/auth/data/services/admin_auth_service.dart';
import '../../features/auth/presentation/view_model/auth_cubit.dart';
import '../../features/member_details/data/member_details_service.dart';
import '../../features/member_details/presentation/view_model/member_details_cubit.dart';
import '../../features/members/data/members_service.dart';
import '../../features/members/presentation/view_model/members_cubit.dart';
import '../../features/profile/data/services/profile_service.dart';
import '../../features/profile/presentation/view_model/profile_cubit.dart';
import '../../features/profile/presentation/view_model/profile_repo.dart';
import '../../features/society_management/presentation/viewmodel/society_cubit.dart';
import '../api/app_interceptors.dart';
import '../cache/cache_helper.dart';
import '../localization/cubit/localization_cubit.dart';

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
        AppInterceptors(),
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
  getIt.registerLazySingleton<ProfileService>(
        () => ProfileService(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepo>(
        () => ProfileRepo(
      getIt<ProfileService>(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
        () => ProfileCubit(
      getIt<ProfileRepo>(),
    ),
  );
  getIt.registerLazySingleton<MembersService>(
        () => MembersService(getIt<Dio>()),
  );
  getIt.registerFactory<MembersCubit>(
        () => MembersCubit(),
  );
  getIt.registerLazySingleton<MemberDetailsService>(
        () => MemberDetailsService(
      getIt<Dio>(),
    ),
  );
  getIt.registerFactory<MemberDetailsCubit>(
        () => MemberDetailsCubit(),
  );
  getIt.registerLazySingleton<MembershipService>(
        () => MembershipService(),
  );

  getIt.registerFactory<MemberCirclesCubit>(
        () => MemberCirclesCubit(),
  );
  getIt.registerFactory<SocietyCubit>(
        () => SocietyCubit(getIt()),
  );
}