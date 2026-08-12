import 'package:jameya_admin/core/cache/cache_helper.dart';
import 'package:jameya_admin/core/cache/cache_key.dart';
import 'package:jameya_admin/core/services/services_locator.dart';

abstract class SharedPreferencesService {
  // --- This methods are used to save and get data about login status ---
  static Future<void> setLoggedIn(bool value) async {
    await getIt<CacheHelper>().saveData(key: CacheKey.isLoggedIn, value: value);
  }

  static bool isLoggedIn() {
    return getIt<CacheHelper>().getData(key: CacheKey.isLoggedIn) ?? false;
  }

  static Future<void> clearAuthData() async {
    await getIt<CacheHelper>().deleteData(key: CacheKey.id);
    await getIt<CacheHelper>().deleteData(key: CacheKey.userDataKey);
    await getIt<CacheHelper>().deleteData(key: CacheKey.isLoggedIn);
  }

  // --- This methods are used to save and get data about onboarding status ---
  static Future<void> setOnBoardingViewed([bool value = true]) async {
    await getIt<CacheHelper>().saveData(
      key: CacheKey.onBoardingViewed,
      value: value,
    );
    await getIt<CacheHelper>().saveData(
      key: 'isOnboardingCompleted',
      value: value,
    );
  }

  static Future<void> resetOnBoarding() async {
    await getIt<CacheHelper>().deleteData(key: CacheKey.onBoardingViewed);
    await getIt<CacheHelper>().deleteData(key: 'isOnboardingCompleted');
  }

  static bool isOnBoardingViewed() {
    final bool key1 = getIt<CacheHelper>().getBool(key: CacheKey.onBoardingViewed) ?? false;
    final bool key2 = getIt<CacheHelper>().getBool(key: 'isOnboardingCompleted') ?? false;
    return key1 || key2;
  }
}
