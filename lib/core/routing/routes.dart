// All named route paths used with GoRouter
abstract final class AppRoutes {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAdminLoginView = '/admin-login';
  static const kCreateJameyaView = '/create-jameya';

  // Home (Main Shell) route
  static const kHomeView = '/home';
  static const kSocietyManagementView = '/society-management';
  static const kSocietyDetailsView = '/society-details';

  // Tasks feature routes
  static const kOverduePaymentsView = '/overdue-payments';
  static const kDelayDetailsView = '/delay-details';
  static const kReviewPaymentsView = '/review-payments';
  static const kExpensesView = '/expenses';
  // Member Verification routes
  static const kMemberVerificationListView = '/member-verification-list';
  static const kMemberVerificationDetailView = '/member-verification-detail';
}