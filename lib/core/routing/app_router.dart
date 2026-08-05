import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya/core/animations/smart_animate_transition.dart';
import 'package:jameya/core/routing/routes.dart';
import 'package:jameya/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:jameya/features/onboarding/presentation/viewmodel/onboarding_cubit.dart';
import 'package:jameya/features/splash/view/splash_view.dart';
import 'package:jameya/features/society_management/presentation/view/society_management_view.dart';
import 'package:jameya/features/society_management/presentation/view/society_details_view.dart';
import 'package:jameya/features/society_management/data/models/society_model.dart';
import 'package:jameya/features/home/presentation/view/main_view.dart';
import 'package:jameya/features/tasks/data/models/overdue_payment_model.dart';
import 'package:jameya/features/tasks/presentation/view/overdue_payments_view.dart';
import 'package:jameya/features/tasks/presentation/view/delay_details_view.dart';
import 'package:jameya/features/tasks/presentation/view/review_payments_view.dart';
import 'package:jameya/features/tasks/presentation/view/expenses_view.dart';
import 'package:jameya/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:jameya/features/auth/views/admin_login_view.dart';
import 'package:jameya/core/services/services_locator.dart';

// Defines the app's navigation using GoRouter
abstract final class AppRouter {
  static final router = GoRouter(
    routes: [
      //* ── Splash ─────────────────────────────────────
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),

      //* ── Onboarding ──────────────────────────────────
      GoRoute(
        path: AppRoutes.kOnboardingView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnboardingView(),
          ),
        ),
      ),

      //* ── Admin Login ─────────────────────────────────
      GoRoute(
        path: AppRoutes.kAdminLoginView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const AdminLoginView(),
          ),
        ),
      ),

      //* ── Home (Main Shell) ───────────────────────────
      GoRoute(
        path: AppRoutes.kHomeView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const MainView(),
        ),
      ),

      //* ── Society Management ────────────────────────
      GoRoute(
        path: AppRoutes.kSocietyManagementView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const SocietyManagementView(),
        ),
      ),

      //* ── Society Details ───────────────────────────
      GoRoute(
        path: AppRoutes.kSocietyDetailsView,
        pageBuilder: (context, state) {
          final society = state.extra as SocietyModel;
          return SmartAnimateTransition.buildPage(
            state: state,
            child: SocietyDetailsView(society: society),
          );
        },
      ),

      //* ── Overdue Payments ──────────────────────────
      GoRoute(
        path: AppRoutes.kOverduePaymentsView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const OverduePaymentsView(),
        ),
      ),

      //* ── Delay Details ─────────────────────────────
      GoRoute(
        path: AppRoutes.kDelayDetailsView,
        pageBuilder: (context, state) {
          final payment = state.extra as OverduePaymentModel;
          return SmartAnimateTransition.buildPage(
            state: state,
            child: DelayDetailsView(payment: payment),
          );
        },
      ),

      //* ── Review Payments ───────────────────────────
      GoRoute(
        path: AppRoutes.kReviewPaymentsView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const ReviewPaymentsView(),
        ),
      ),

      //* ── Expenses ───────────────────────────────────
      GoRoute(
        path: AppRoutes.kExpensesView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: const ExpensesView(),
        ),
      ),
    ],
  );
}
