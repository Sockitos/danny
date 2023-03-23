import 'dart:io';

import 'package:danny/models/achievement.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/services/bluetooth_service.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:permission_handler/permission_handler.dart';

class BackgroundService {
  BackgroundService() {
    checkPermissions();
  }

  late BluetoothService blue;
  late FirestoreDatabase db;
  UserData? info;
  List<Achievement>? achievements;

  Future<void> checkPermissions() async {
    if (Platform.isAndroid) {
      if (!await Permission.location.request().isGranted) {
        return Future.error(Exception('Location permission not granted'));
      }
    }
    if (!await Permission.storage.request().isGranted) {
      return Future.error(Exception('Storage permission not granted'));
    }
  }

  Future<void> start(FirestoreDatabase database) async {
    db = database;
    blue = BluetoothService(database: db)..start();

    info = await db.userInfoStream().first;
    achievements = await db.achievementsStream().first;
    db.userInfoStream().listen((data) => info = data);
    db.achievementsStream().listen((data) => achievements = data);

    db.userTrackersStream().listen((data) async {
      await blue.sendConfig();
      await db.setUserInfo(
        info!.copyWith(
          trackers: data.length,
          rawAchievements: checkAchievements(
            info!.ratings,
            data.length,
            info!.streak,
            info!.danny,
            info!.generated,
            info!.shared,
          ),
        ),
      );
    });

    db.ratingsStream().listen((data) {
      var streak = 0;
      var maxStreak = 0;
      DateTime comp;
      if (data.isNotEmpty) streak = 1;
      for (var i = 1; i < data.length; i++) {
        comp = data[i - 1].auxTimestamp;
        if ((data[i].auxTimestamp.year == comp.year) &&
            (data[i].auxTimestamp.month == comp.month) &&
            (data[i].auxTimestamp.day == comp.day)) continue;

        comp = data[i - 1].auxTimestamp.add(const Duration(days: 1));
        if ((data[i].auxTimestamp.year == comp.year) &&
            (data[i].auxTimestamp.month == comp.month) &&
            (data[i].auxTimestamp.day == comp.day)) {
          streak++;
        } else {
          if (streak > maxStreak) maxStreak = streak;
          streak = 1;
        }
      }

      if (streak > maxStreak) maxStreak = streak;

      db.setUserInfo(
        info!.copyWith(
          ratings: data.length,
          streak: maxStreak,
          rawAchievements: checkAchievements(
            data.length,
            info!.trackers,
            maxStreak,
            info!.danny,
            info!.generated,
            info!.shared,
          ),
        ),
      );
    });
  }

  void stop() => blue.stop();

  String checkAchievements(
    int ratings,
    int trackers,
    int streak,
    int danny,
    int generated,
    int shared,
  ) {
    final values = <String, int>{
      'ratings': ratings,
      'trackers': trackers,
      'streak': streak,
      'danny': danny,
      'generated': generated,
      'shared': shared,
    };
    var nAchievements = '';

    final achievementList = [...?achievements];
    achievementList.removeLast();

    for (final a in achievementList) {
      if (values[a.value]! >= a.condition) {
        nAchievements += '1';
      } else {
        nAchievements += '0';
      }
    }
    if (!nAchievements.contains('0') &&
        (danny > achievements!.last.condition)) {
      nAchievements += '1';
    } else {
      nAchievements += '0';
    }

    for (var i = 0; i < nAchievements.length; i++) {
      // if (info.achievements[i] == '0' && nAchievements[i] == '1')
      // Scaffold.of(scaffoldContext).showSnackBar(
      //   SnackBar(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     elevation: 0,
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: AppColors.kprimary,
      //     content: AchievementNotification(),
      //   ),
      // );
    }
    return nAchievements;
  }

  void incDanny() {
    db.setUserInfo(
      info!.copyWith(
        danny: info!.danny + 1,
        rawAchievements: checkAchievements(
          info!.ratings,
          info!.trackers,
          info!.streak,
          info!.danny + 1,
          info!.generated,
          info!.shared,
        ),
      ),
    );
  }

  void incGenerated() {
    db.setUserInfo(
      info!.copyWith(
        generated: info!.generated + 1,
        rawAchievements: checkAchievements(
          info!.ratings,
          info!.trackers,
          info!.streak,
          info!.danny,
          info!.generated + 1,
          info!.shared,
        ),
      ),
    );
  }

  void incShared() {
    db.setUserInfo(
      info!.copyWith(
        shared: info!.shared + 1,
        rawAchievements: checkAchievements(
          info!.ratings,
          info!.trackers,
          info!.streak,
          info!.danny,
          info!.generated,
          info!.shared + 1,
        ),
      ),
    );
  }
}
