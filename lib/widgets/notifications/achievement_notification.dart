import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class AchievementNotification extends StatelessWidget {
  const AchievementNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          CustomIcons.achievement,
          color: Colors.white,
          size: 22,
        ),
        SizedBox(width: 10),
        Text(
          'New Achievement Unlocked!',
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
