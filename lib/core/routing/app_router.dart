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
    ],
  );
}
