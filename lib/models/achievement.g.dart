// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Achievement _$$_AchievementFromJson(Map<String, dynamic> json) =>
    _$_Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      lvl: json['lvl'] as int,
      value: json['value'] as String,
      condition: json['condition'] as int,
      unlocked: json['unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AchievementToJson(_$_Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'lvl': instance.lvl,
      'value': instance.value,
      'condition': instance.condition,
      'unlocked': instance.unlocked,
    };
