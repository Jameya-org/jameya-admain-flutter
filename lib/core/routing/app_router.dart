import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jameya_admin/core/animations/smart_animate_transition.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/features/member_verification/data/models/member_verification_model.dart';
import 'package:jameya_admin/features/member_verification/presentation/view/member_verification_detail_view.dart';
import 'package:jameya_admin/features/member_verification/presentation/view/member_verification_list_view.dart';
import 'package:jameya_admin/core/services/services_locator.dart';
import 'package:jameya_admin/core/widgets/custom_error_view.dart';

// Auth
import 'package:jameya_admin/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:jameya_admin/features/auth/views/admin_login_view.dart';

// Onboarding
import 'package:jameya_admin/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:jameya_admin/features/onboarding/presentation/viewmodel/onboarding_cubit.dart';

// Splash
import 'package:jameya_admin/features/splash/view/splash_view.dart';

// Home
import 'package:jameya_admin/features/home/presentation/view/main_view.dart';

// Create Jameya
import 'package:jameya_admin/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya_admin/features/create_jameya/presentation/view/create_jameya_view.dart';

// Society Management
import 'package:jameya_admin/features/society_management/data/models/society_model.dart';
import 'package:jameya_admin/features/society_management/presentation/view/society_details_view.dart';
import 'package:jameya_admin/features/society_management/presentation/view/society_management_view.dart';

// Tasks
import 'package:jameya_admin/features/tasks/data/models/overdue_payment_model.dart';
import 'package:jameya_admin/features/tasks/presentation/view/delay_details_view.dart';
import 'package:jameya_admin/features/tasks/presentation/view/expenses_view.dart';
import 'package:jameya_admin/features/tasks/presentation/view/overdue_payments_view.dart';
import 'package:jameya_admin/features/tasks/presentation/view/review_payments_view.dart';

// Profile
import 'package:jameya_admin/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:jameya_admin/features/profile/presentation/views/profile_view.dart';

// Members

// Member Details
import 'package:jameya_admin/features/member_details/models/member_details_model.dart';
import 'package:jameya_admin/features/member_details/presentation/view_model/member_details_cubit.dart';
import 'package:jameya_admin/features/member_details/views/member_details_view.dart';

// Member Circles

// Member Payments
import 'package:jameya_admin/features/member_payments/views/member_payments_view.dart';

import '../../features/ member_circles/ views/member_circles_view.dart';
import '../../features/members/ views/members_view.dart';

abstract final class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return CustomErrorViewForAppRouter(
        path: state.uri.toString(),
        errorMessage: state.error?.toString(),
        onRetry: () => context.go(AppRoutes.kHomeView),
      );
    },

    routes: [
      // =========================================================
      // Splash
      // =========================================================
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),

      // =========================================================
      // Onboarding
      // =========================================================
      GoRoute(
        path: AppRoutes.kOnboardingView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: BlocProvider(
              create: (_) => OnboardingCubit(),
              child: const OnboardingView(),
            ),
          );
        },
      ),

      // =========================================================
      // Create Jameya
      // =========================================================
      GoRoute(
        path: AppRoutes.kCreateJameyaView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: BlocProvider(
              create: (_) => getIt<CreateJameyaCubit>(),
              child: const CreateJameyaView(),
            ),
          );
        },
      ),

      // =========================================================
      // Admin Login
      // =========================================================
      GoRoute(
        path: AppRoutes.kAdminLoginView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: BlocProvider(
              create: (_) => getIt<AuthCubit>(),
              child: const AdminLoginView(),
            ),
          );
        },
      ),

      // =========================================================
      // Home
      // =========================================================
      GoRoute(
        path: AppRoutes.kHomeView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: const MainView(),
          );
        },
      ),

      // =========================================================
      // Profile
      // =========================================================
      GoRoute(
        path: AppRoutes.kProfileView,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<ProfileCubit>()..getProfile(),
            child: const ProfileView(),
          );
        },
      ),

      // =========================================================
      // Members
      // =========================================================
      GoRoute(
        path: AppRoutes.kMembersView,
        builder: (context, state) {
          return const MembersView();
        },
      ),

      // =========================================================
      // Member Details
      // =========================================================
      GoRoute(
        path: '${AppRoutes.memberDetails}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;

          return BlocProvider(
            create: (_) =>
            getIt<MemberDetailsCubit>()..getMember(id),
            child: MemberDetailsView(
              memberId: id,
            ),
          );
        },
      ),

      // =========================================================
      // Member Circles
      // =========================================================
      GoRoute(
        path: AppRoutes.memberCircles,
        builder: (context, state) {
          final member = state.extra;

          if (member is! MemberDetailsModel) {
            return const MembersView();
          }

          return MemberCirclesView(
            member: member,
          );
        },
      ),

      // =========================================================
      // Member Payments
      // =========================================================
      GoRoute(
        path: AppRoutes.memberPayments,
        builder: (context, state) {
          final member = state.extra;

          if (member is! MemberDetailsModel) {
            return const MembersView();
          }

          return MemberPaymentsView(
            member: member,
          );
        },
      ),

      // =========================================================
      // Society Management
      // =========================================================
      GoRoute(
        path: AppRoutes.kSocietyManagementView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: const SocietyManagementView(),
          );
        },
      ),

      // =========================================================
      // Society Details
      // =========================================================
      GoRoute(
        path: AppRoutes.kSocietyDetailsView,
        pageBuilder: (context, state) {
          final society = state.extra;

          if (society is! SocietyModel) {
            return SmartAnimateTransition.buildPage(
              state: state,
              child: const SocietyManagementView(),
            );
          }

          return SmartAnimateTransition.buildPage(
            state: state,
            child: SocietyDetailsView(
              society: society,
            ),
          );
        },
      ),

      // =========================================================
      // Overdue Payments
      // =========================================================
      GoRoute(
        path: AppRoutes.kOverduePaymentsView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: const OverduePaymentsView(),
          );
        },
      ),

      // =========================================================
      // Delay Details
      // =========================================================
      GoRoute(
        path: AppRoutes.kDelayDetailsView,
        pageBuilder: (context, state) {
          final payment = state.extra;

          if (payment is! OverduePaymentModel) {
            return SmartAnimateTransition.buildPage(
              state: state,
              child: const OverduePaymentsView(),
            );
          }

          return SmartAnimateTransition.buildPage(
            state: state,
            child: DelayDetailsView(
              payment: payment,
            ),
          );
        },
      ),

      // =========================================================
      // Review Payments
      // =========================================================
      GoRoute(
        path: AppRoutes.kReviewPaymentsView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: const ReviewPaymentsView(),
          );
        },
      ),

      // =========================================================
      // Expenses
      // =========================================================
      GoRoute(
        path: AppRoutes.kExpensesView,
        pageBuilder: (context, state) {
          return SmartAnimateTransition.buildPage(
            state: state,
            child: const ExpensesView(),
          );
        },
      ),

      //* ── Member Verification List ───────────────────
      GoRoute(
        path: AppRoutes.kMemberVerificationListView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const MemberVerificationListView(),
        ),
      ),

      //* ── Member Verification Detail ─────────────────
      GoRoute(
        path: AppRoutes.kMemberVerificationDetailView,
        pageBuilder: (context, state) {
          final member = state.extra;
          if (member is! MemberVerificationModel) {
            return SmartAnimateTransition.buildPage(
              state: state,
              child: const MemberVerificationListView(),
            );
          }
          return SmartAnimateTransition.buildPage(
            state: state,
            child: MemberVerificationDetailView(member: member),
          );
        },
      ),
    ],
  );
}