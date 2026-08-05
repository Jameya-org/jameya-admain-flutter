import 'package:flutter/foundation.dart';
import 'package:jameya/core/services/secure_storage_service.dart';
import 'package:jameya/core/services/shared_preferences_service.dart';

Future<void> logout() async {
  try {
    await SecureStorageService.deleteTokens();
    await SharedPreferencesService.clearAuthData();
    if (!kReleaseMode) {
      debugPrint('Logged out successfully & tokens cleared.');
    }
  } catch (e) {
    if (!kReleaseMode) {
      debugPrint('Error during logout: $e');
    }
  }
}
