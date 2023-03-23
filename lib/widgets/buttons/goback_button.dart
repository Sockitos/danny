import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    Key? key,
    this.light = false,
  }) : super(key: key);

  final bool light;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          child: Icon(
            CustomIcons.back,
            color: light
                ? Colors.white.withOpacity(0.5)
                : AppColors.ksecondary.withOpacity(0.25),
            size: 24,
          ),
        ),
        onTap: () {
          Feedback.forTap(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
