class EndPoints {
  static const String baseUrl = 'https://jameya-backend.onrender.com';

  // Auth & Admin Auth
  static const String requestOtp = '/auth/request-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';
  static const String adminLogin = '/admin/auth/login';
  static const String adminRefresh = '/admin/auth/refresh';
  static const String adminLogout = '/admin/auth/logout';

  // Admin Profile & Dashboard
  static const String adminProfile = '/admin/profile';
  static const String adminPassword = '/admin/profile/password';
  static const String adminDashboard = '/admin/dashboard';

  // Fee Policies
  static const String feePolicies = '/admin/fee-policies';
  static const String activeFeePolicy = '/admin/fee-policies/active';

  // Circles / Societies
  static const String adminCircles = '/admin/circles';
  static const String customerCircles = '/customer/circles';

  // Admin User & Customer Management
  static const String adminUsers = '/admin/users';
  static const String adminCustomers = '/admin/customers';
  static const String adminRoles = '/admin/roles';

  // Payments & Payouts & Installments
  static const String paymentProofs = '/admin/payment-proofs';
  static const String transactions = '/admin/transactions';
  static const String adminInstallments = '/admin/installments';
  static const String payouts = '/admin/payouts';

  // KYC & Eligibility
  static const String pendingKycDocs = '/admin/kyc/pending-documents';
  static const String kycEligibility = '/admin/kyc/eligibility';
  static String reviewKycDocument(String id) => '/admin/kyc/documents/$id/review';
}
