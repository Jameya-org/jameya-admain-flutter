// All named route paths used with GoRouter
abstract final class AppRoutes {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAdminLoginView = '/admin-login';

  // Create Jameya
  static const kCreateJameyaView = '/create-jameya';

  // Home
  static const kHomeView = '/home';

  // Profile
  static const kProfileView = '/profile';

  // Members
  static const kMembersView = '/members';
  static const memberDetails = '/member-details';
  static const memberCircles = '/member-circles';
  static const memberPayments = '/member-payments';

  // Society Management
  static const kSocietyManagementView = '/society-management';
  static const kSocietyDetailsView = '/society-details';

  // Tasks
  static const kOverduePaymentsView = '/overdue-payments';
  static const kDelayDetailsView = '/delay-details';
  static const kReviewPaymentsView = '/review-payments';
  static const kExpensesView = '/expenses';
}