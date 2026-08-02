import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jameya/core/cache/cache_helper.dart';
import 'package:jameya/core/routing/routes.dart';
import 'package:jameya/core/services/services_locator.dart';

import '../controllers/splash_controller.dart';
import '../widgets/animated_logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController controller = SplashController();

  @override
  void initState() {
    super.initState();

    // Re-render the widget whenever the controller notifies a change
    controller.addListener(_onControllerUpdate);

    // Kick off the typing animation
    controller.startTyping();
  }

  void _onControllerUpdate() {
    if (!mounted) return;
    setState(() {});

    if (controller.animationCompleted) {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    final bool isOnboardingCompleted =
        getIt<CacheHelper>().getBool(key: 'isOnboardingCompleted') ?? false;

    if (isOnboardingCompleted) {
      context.go(AppRoutes.kHomeView);
    } else {
      context.go(AppRoutes.kOnboardingView);
    }
  }

  @override
  void dispose() {
    // Cancel timer and release the ChangeNotifier
    controller.removeListener(_onControllerUpdate);
    controller.disposeController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedLogo(
                text: controller.displayedText,
                moveUp: controller.moveUp,
                maxHeight: constraints.maxHeight,
              ),
            ],
          );
        },
      ),
    );
  }
}
