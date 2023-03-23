import 'package:danny/screens/main/profile/achievements/achievements_screen.dart';
import 'package:danny/screens/main/profile/sharing/generate/generate_screen.dart';
import 'package:danny/screens/main/profile/sharing/sharing_screen.dart';
import 'package:danny/screens/other/weekly_screen.dart';
import 'package:danny/screens/welcome/login/login_screen.dart';
import 'package:danny/screens/welcome/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/achievements':
        return PageTransition<void>(
          type: PageTransitionType.fade,
          child: const AchievementsScreen(),
        );

      case '/sharing':
        return PageTransition<void>(
          type: PageTransitionType.fade,
          child: const SharingScreen(),
        );

      case '/generate':
        return PageTransition<void>(
          type: PageTransitionType.topToBottom,
          child: const GenerateScreen(),
        );

      case '/weekly':
        return PageTransition<void>(
          type: PageTransitionType.fade,
          child: const WeeklyScreen(),
        );

      case '/login':
        return PageTransition<void>(
          type: PageTransitionType.rightToLeft,
          child: const LoginScreen(),
        );

      case '/onboarding':
        return PageTransition<void>(
          type: PageTransitionType.bottomToTop,
          child: const OnboardingScreen(),
        );

      default:
        return PageTransition<void>(
          type: PageTransitionType.bottomToTop,
          child: const OnboardingScreen(),
        );
    }
  }
}
