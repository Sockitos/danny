import 'package:danny/constants/colors.dart';
import 'package:danny/models/achievement.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/screens/main/profile/achievements/components/achievement_card.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/widgets/buttons/goback_button.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final achievements = database.achievementsStream();
    final userInfo = database.userInfoStream();
    final combined = CombineLatestStream.combine2<List<Achievement>, UserData,
        List<Achievement>>(
      achievements,
      userInfo,
      (acvs, ui) {
        final tf = ui.achievements;
        for (var i = 0; i < acvs.length; i++) {
          if (tf[i]) acvs[i] = acvs[i].copyWith(unlocked: true);
        }
        return acvs;
      },
    ).asBroadcastStream();

    return Scaffold(
      backgroundColor: AppColors.kbackground,
      body: SafeArea(
        child: Stack(
          children: [
            const GoBackButton(),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const DannyAvatar(),
                  const SizedBox(height: 20),
                  const Text(
                    'Congrats!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ksecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<Achievement>>(
                    stream: combined,
                    builder: (context, snapshot) {
                      final achievementsList = snapshot.data ?? [];
                      var counter = 0;
                      final total = achievementsList.length;
                      for (final a in achievementsList) {
                        if (a.unlocked) counter++;
                      }

                      return Text(
                        "You've unlocked $counter/$total achievements",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ksecondary.withOpacity(0.3),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Material(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: StreamBuilder<List<Achievement>>(
                          stream: combined,
                          initialData: const [],
                          builder: (context, snapshot) {
                            final achievementsList = snapshot.data ?? [];

                            return GridView.builder(
                              itemCount: achievementsList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                return AchievementCard(
                                  achievement: achievementsList[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
