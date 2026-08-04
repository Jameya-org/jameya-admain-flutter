import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya/core/animations/smart_animate_transition.dart';
import 'package:jameya/core/routing/routes.dart';
import 'package:jameya/core/services/services_locator.dart';
import 'package:jameya/features/create_jameya/presentation/cubit/create_jameya_cubit.dart';
import 'package:jameya/features/create_jameya/presentation/view/create_jameya_view.dart';
import 'package:jameya/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:jameya/features/onboarding/presentation/viewmodel/onboarding_cubit.dart';
import 'package:jameya/features/splash/view/splash_view.dart';
import 'package:jameya/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:jameya/features/auth/views/admin_login_view.dart';

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

      //* ── Create Jameya ───────────────────────────────
      GoRoute(
        path: AppRoutes.kCreateJameyaView,
        pageBuilder: (context, state) => SmartAnimateTransition.buildPage(
          state: state,
          child: BlocProvider(
            // Factory registration ensures a fresh cubit per navigation
            create: (_) => getIt<CreateJameyaCubit>(),
            child: const CreateJameyaView(),
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
    ],
  );
}
