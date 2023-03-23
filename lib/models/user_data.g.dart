// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      trackers: json['trackers'] as int,
      ratings: json['ratings'] as int,
      streak: json['streak'] as int,
      danny: json['danny'] as int,
      generated: json['generated'] as int,
      shared: json['shared'] as int,
      rawAchievements: json['achievements'] as String,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
      enableRatings: json['enableRatings'] as bool,
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'trackers': instance.trackers,
      'ratings': instance.ratings,
      'streak': instance.streak,
      'danny': instance.danny,
      'generated': instance.generated,
      'shared': instance.shared,
      'achievements': instance.rawAchievements,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'enableRatings': instance.enableRatings,
    };
