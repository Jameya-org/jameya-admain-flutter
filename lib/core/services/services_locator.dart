import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jameya_admin/core/api/api_services.dart';
import 'package:jameya_admin/core/api/app_interceptors.dart';
import 'package:jameya_admin/core/cache/cache_helper.dart';
import 'package:jameya_admin/core/api/api_services_implementation.dart';
import 'package:jameya_admin/core/localization/cubit/localization_cubit.dart';
import 'package:jameya_admin/core/services/dio_factory.dart';
import 'package:jameya_admin/features/auth/data/services/admin_auth_service.dart';
import 'package:jameya_admin/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:jameya_admin/features/create_jameya/data/datasource/create_jameya_remote_data_source.dart';
import 'package:jameya_admin/features/create_jameya/data/datasource/create_jameya_remote_data_source_impl.dart';
import 'package:jameya_admin/features/create_jameya/data/repositories/create_jameya_repository_impl.dart';
import 'package:jameya_admin/features/create_jameya/domain/repositories/create_jameya_repository.dart';
import 'package:jameya_admin/features/create_jameya/domain/usecases/create_jameya_usecase.dart';
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/home/data/repos/home_repo.dart';
import 'package:jameya_admin/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:jameya_admin/features/society_management/data/repos/society_repo.dart';
import 'package:jameya_admin/features/society_management/presentation/viewmodel/society_cubit.dart';
import 'package:jameya_admin/features/member_verification/data/repos/member_verification_repo.dart';
import 'package:jameya_admin/features/member_verification/presentation/viewmodel/member_verification_cubit.dart';
import 'package:jameya_admin/features/tasks/data/repos/tasks_repo.dart';
import 'package:jameya_admin/features/tasks/presentation/manager/tasks_cubit.dart';
import '../../features/ member_circles/data/membership_service.dart';
import '../../features/ member_circles/presentation/view_model/member_circles_cubit.dart';
import '../../features/member_details/data/member_details_service.dart';
import '../../features/member_details/presentation/view_model/member_details_cubit.dart';
import '../../features/members/data/members_service.dart';
import '../../features/members/presentation/view_model/members_cubit.dart';
import '../../features/profile/data/services/profile_service.dart';
import '../../features/profile/presentation/view_model/profile_cubit.dart';
import '../../features/profile/presentation/view_model/profile_repo.dart';

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
  getIt.registerLazySingleton<TasksRepo>(() => TasksRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton<MemberVerificationRepo>(
    () => MemberVerificationRepo(getIt<ApiServices>()),
  );

  getIt.registerFactory<MemberCirclesCubit>(
        () => MemberCirclesCubit(),
  );
  getIt.registerFactory<SocietyCubit>(
        () => SocietyCubit(getIt()),
  );
  getIt.registerFactory<ExpensesCubit>(() => ExpensesCubit(getIt<TasksRepo>()));
  getIt.registerFactory<MemberVerificationCubit>(
    () => MemberVerificationCubit(getIt<MemberVerificationRepo>()),
  );
}
