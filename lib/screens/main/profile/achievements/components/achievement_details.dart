import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/achievement.dart';
import 'package:flutter/material.dart';

class AchievementDetails extends StatelessWidget {
  const AchievementDetails({
    required this.achievement,
    Key? key,
  }) : super(key: key);

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kbackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Feedback.forTap(context);
                Navigator.pop(context, false);
              },
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Icon(
                      CustomIcons.star,
                      size: 140,
                      color: achievement.getColor(),
                    ),
                    const Icon(
                      CustomIcons.hand,
                      size: 140,
                      color: AppColors.kprimary,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  achievement.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ksecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    achievement.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ksecondary.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
