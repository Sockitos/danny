import 'package:animations/animations.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/achievement.dart';
import 'package:danny/screens/main/profile/achievements/components/achievement_details.dart';
import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Opacity(
        opacity: achievement.unlocked ? 1.0 : 0.5,
        child: AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            onTap: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AchievementDetails(achievement: achievement),
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black54,
              transitionDuration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeScaleTransition(animation: animation, child: child);
              },
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: Ink(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(5, 10),
                    color: AppColors.ksecondary.withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Icon(
                        CustomIcons.star,
                        size: 50,
                        color: achievement.unlocked
                            ? achievement.getColor()
                            : AppColors.ksecondary.withOpacity(0.25),
                      ),
                      Icon(
                        CustomIcons.hand,
                        size: 50,
                        color: achievement.unlocked
                            ? AppColors.kprimary
                            : AppColors.ksecondary.withOpacity(0.25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    achievement.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ksecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
