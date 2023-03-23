// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
class _$RatingTearOff {
  const _$RatingTearOff();

  _Rating call(
      {required String id,
      required String tracker,
      required int rating,
      @JsonKey(fromJson: fromMillis, toJson: toMillis)
          required DateTime timestamp,
      String imageUrl1 = '',
      String imageUrl2 = '',
      String imageUrl3 = ''}) {
    return _Rating(
      id: id,
      tracker: tracker,
      rating: rating,
      timestamp: timestamp,
      imageUrl1: imageUrl1,
      imageUrl2: imageUrl2,
      imageUrl3: imageUrl3,
    );
  }

  Rating fromJson(Map<String, Object?> json) {
    return Rating.fromJson(json);
  }
}

/// @nodoc
const $Rating = _$RatingTearOff();

/// @nodoc
mixin _$Rating {
  String get id => throw _privateConstructorUsedError;
  String get tracker => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromMillis, toJson: toMillis)
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get imageUrl1 => throw _privateConstructorUsedError;
  String get imageUrl2 => throw _privateConstructorUsedError;
  String get imageUrl3 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String tracker,
      int rating,
      @JsonKey(fromJson: fromMillis, toJson: toMillis) DateTime timestamp,
      String imageUrl1,
      String imageUrl2,
      String imageUrl3});
}

/// @nodoc
class _$RatingCopyWithImpl<$Res> implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  final Rating _value;
  // ignore: unused_field
  final $Res Function(Rating) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? tracker = freezed,
    Object? rating = freezed,
    Object? timestamp = freezed,
    Object? imageUrl1 = freezed,
    Object? imageUrl2 = freezed,
    Object? imageUrl3 = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tracker: tracker == freezed
          ? _value.tracker
          : tracker // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl1: imageUrl1 == freezed
          ? _value.imageUrl1
          : imageUrl1 // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl2: imageUrl2 == freezed
          ? _value.imageUrl2
          : imageUrl2 // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl3: imageUrl3 == freezed
          ? _value.imageUrl3
          : imageUrl3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RatingCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$RatingCopyWith(_Rating value, $Res Function(_Rating) then) =
      __$RatingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String tracker,
      int rating,
      @JsonKey(fromJson: fromMillis, toJson: toMillis) DateTime timestamp,
      String imageUrl1,
      String imageUrl2,
      String imageUrl3});
}

/// @nodoc
class __$RatingCopyWithImpl<$Res> extends _$RatingCopyWithImpl<$Res>
    implements _$RatingCopyWith<$Res> {
  __$RatingCopyWithImpl(_Rating _value, $Res Function(_Rating) _then)
      : super(_value, (v) => _then(v as _Rating));

  @override
  _Rating get _value => super._value as _Rating;

  @override
  $Res call({
    Object? id = freezed,
    Object? tracker = freezed,
    Object? rating = freezed,
    Object? timestamp = freezed,
    Object? imageUrl1 = freezed,
    Object? imageUrl2 = freezed,
    Object? imageUrl3 = freezed,
  }) {
    return _then(_Rating(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tracker: tracker == freezed
          ? _value.tracker
          : tracker // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl1: imageUrl1 == freezed
          ? _value.imageUrl1
          : imageUrl1 // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl2: imageUrl2 == freezed
          ? _value.imageUrl2
          : imageUrl2 // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl3: imageUrl3 == freezed
          ? _value.imageUrl3
          : imageUrl3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Rating extends _Rating {
  const _$_Rating(
      {required this.id,
      required this.tracker,
      required this.rating,
      @JsonKey(fromJson: fromMillis, toJson: toMillis) required this.timestamp,
      this.imageUrl1 = '',
      this.imageUrl2 = '',
      this.imageUrl3 = ''})
      : super._();

  factory _$_Rating.fromJson(Map<String, dynamic> json) =>
      _$$_RatingFromJson(json);

  @override
  final String id;
  @override
  final String tracker;
  @override
  final int rating;
  @override
  @JsonKey(fromJson: fromMillis, toJson: toMillis)
  final DateTime timestamp;
  @JsonKey(defaultValue: '')
  @override
  final String imageUrl1;
  @JsonKey(defaultValue: '')
  @override
  final String imageUrl2;
  @JsonKey(defaultValue: '')
  @override
  final String imageUrl3;

  @override
  String toString() {
    return 'Rating(id: $id, tracker: $tracker, rating: $rating, timestamp: $timestamp, imageUrl1: $imageUrl1, imageUrl2: $imageUrl2, imageUrl3: $imageUrl3)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Rating &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tracker, tracker) || other.tracker == tracker) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.imageUrl1, imageUrl1) ||
                other.imageUrl1 == imageUrl1) &&
            (identical(other.imageUrl2, imageUrl2) ||
                other.imageUrl2 == imageUrl2) &&
            (identical(other.imageUrl3, imageUrl3) ||
                other.imageUrl3 == imageUrl3));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, tracker, rating, timestamp,
      imageUrl1, imageUrl2, imageUrl3);

  @JsonKey(ignore: true)
  @override
  _$RatingCopyWith<_Rating> get copyWith =>
      __$RatingCopyWithImpl<_Rating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RatingToJson(this);
  }
}

abstract class _Rating extends Rating {
  const factory _Rating(
      {required String id,
      required String tracker,
      required int rating,
      @JsonKey(fromJson: fromMillis, toJson: toMillis)
          required DateTime timestamp,
      String imageUrl1,
      String imageUrl2,
      String imageUrl3}) = _$_Rating;
  const _Rating._() : super._();

  factory _Rating.fromJson(Map<String, dynamic> json) = _$_Rating.fromJson;

  @override
  String get id;
  @override
  String get tracker;
  @override
  int get rating;
  @override
  @JsonKey(fromJson: fromMillis, toJson: toMillis)
  DateTime get timestamp;
  @override
  String get imageUrl1;
  @override
  String get imageUrl2;
  @override
  String get imageUrl3;
  @override
  @JsonKey(ignore: true)
  _$RatingCopyWith<_Rating> get copyWith => throw _privateConstructorUsedError;
}
