import 'package:danny/constants/colors.dart';
import 'package:danny/constants/text_styles.dart';
import 'package:danny/widgets/buttons/generic_button.dart';
import 'package:danny/widgets/buttons/text_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kprimary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const DannyAvatar(glow: true, active: false),
              const Text(
                "Hi there,\nI'm Danny",
                textAlign: TextAlign.center,
                style: AppTextStyles.textLightL,
              ),
              const Spacer(),
              Text(
                'Your new personal\nwell-being companion',
                textAlign: TextAlign.center,
                style: AppTextStyles.textLightS,
              ),
              const Spacer(flex: 10),
              GenericButton(
                title: 'HI DANNY!',
                light: true,
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/onboarding',
                ),
              ),
              const SizedBox(height: 10),
              MyTextButton(
                callback: () => Navigator.pushNamed(context, '/login'),
                label: 'I Already have An Account',
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
