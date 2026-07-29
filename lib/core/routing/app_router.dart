import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya_admin/core/animations/smart_animate_transition.dart';
import 'package:jameya_admin/core/routing/routes.dart';
import 'package:jameya_admin/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:jameya_admin/features/onboarding/presentation/viewmodel/onboarding_cubit.dart';
import 'package:jameya_admin/features/splash/view/splash_view.dart';

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
    ],
  );
}
