import 'package:danny/constants/text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingTutorial extends StatelessWidget {
  const OnboardingTutorial({
    Key? key,
    required this.title,
    required this.text,
    this.image,
  }) : super(key: key);

  final String title;
  final String text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: AppTextStyles.textLightM,
            ),
          ),
          const Spacer(),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.textLightS,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
