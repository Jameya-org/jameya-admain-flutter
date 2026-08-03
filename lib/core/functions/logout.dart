import 'package:flutter/foundation.dart';
import 'package:jameya/core/services/secure_storage_service.dart';

Future<void> logout() async {
  try {
    await SecureStorageService.deleteTokens();
    if (!kReleaseMode) {
      debugPrint('Logged out successfully & tokens cleared.');
    }
  } catch (e) {
    if (!kReleaseMode) {
      debugPrint('Error during logout: $e');
    }
  }
}
