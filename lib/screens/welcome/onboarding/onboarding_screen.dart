import 'dart:io';

import 'package:danny/constants/colors.dart';
import 'package:danny/screens/welcome/onboarding/onboarding_pages/onboarding_nickname.dart';
import 'package:danny/screens/welcome/onboarding/onboarding_pages/onboarding_register.dart';
import 'package:danny/screens/welcome/onboarding/onboarding_pages/onboarding_tutorial.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/page_indicator.dart';
import 'package:danny/widgets/step_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  int currentPage = 0;
  String displayName = '';
  File? image;

  void _goToPage(int shift) {
    if (controller.hasClients) {
      currentPage = currentPage + shift;
      if (currentPage == -1) {
        Navigator.pop(context);
        return;
      }
      setState(() {});
      controller.animateToPage(
        currentPage,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
    }
  }

  Future<bool> _onWillPop() async {
    Future.delayed(Duration.zero, () {
      if (currentPage == 0) {
        Navigator.of(context).pop(true);
      } else {
        _goToPage(-1);
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.kprimary,
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  OnboardingNickname(
                    onNameChanged: (value) =>
                        setState(() => displayName = value),
                    onImageChanged: (value) => setState(() => image = value),
                    image: image,
                  ),
                  const OnboardingTutorial(
                    title: 'Start by choosing the measures you want to track..',
                    text:
                        'You can use DAN to rate each one of configured Trackers',
                  ),
                  const OnboardingTutorial(
                    title:
                        'Visualize your Well-Being data or a specific Tracker..',
                    text:
                        'You can also create a report of your data and share with other people',
                  ),
                  OnboardingRegister(
                    displayName: displayName,
                    photo: image,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: DannyAvatar(glow: true, active: false),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                curve: Curves.ease,
                right: currentPage == 4 ? -100 : 17,
                top: 20,
                child: PageIndicator(controller: controller),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                curve: Curves.ease,
                right: currentPage >= 3 ? -100 : 0,
                bottom: 9,
                child: StepIndicator(callback: _goToPage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
