// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Rating _$$_RatingFromJson(Map<String, dynamic> json) => _$_Rating(
      id: json['id'] as String,
      tracker: json['tracker'] as String,
      rating: json['rating'] as int,
      timestamp: fromMillis(json['timestamp'] as int),
      imageUrl1: json['imageUrl1'] as String? ?? '',
      imageUrl2: json['imageUrl2'] as String? ?? '',
      imageUrl3: json['imageUrl3'] as String? ?? '',
    );

Map<String, dynamic> _$$_RatingToJson(_$_Rating instance) => <String, dynamic>{
      'id': instance.id,
      'tracker': instance.tracker,
      'rating': instance.rating,
      'timestamp': toMillis(instance.timestamp),
      'imageUrl1': instance.imageUrl1,
      'imageUrl2': instance.imageUrl2,
      'imageUrl3': instance.imageUrl3,
    };
