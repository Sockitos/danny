import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required int trackers,
    required int ratings,
    required int streak,
    required int danny,
    required int generated,
    required int shared,
    @JsonKey(name: 'achievements') required String rawAchievements,
    required String displayName,
    required String photoUrl,
    required bool enableRatings,
  }) = _UserData;
  const UserData._();

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  List<bool> get achievements {
    final zo = Characters(rawAchievements);
    return zo.map((value) => value == '1').toList();
  }
}
