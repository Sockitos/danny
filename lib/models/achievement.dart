import 'package:danny/constants/colors.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required int lvl,
    required String value,
    required int condition,
    @Default(false) bool unlocked,
  }) = _Achievement;
  const Achievement._();

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  Color getColor() {
    switch (lvl) {
      case 1:
        return AppColors.kbronze;
      case 2:
        return AppColors.ksilver;
      case 3:
        return AppColors.kgold;
      default:
        return AppColors.kprimary;
    }
  }
}
