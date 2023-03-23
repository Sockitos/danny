// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
class _$AchievementTearOff {
  const _$AchievementTearOff();

  _Achievement call(
      {required String id,
      required String title,
      required String description,
      required int lvl,
      required String value,
      required int condition,
      bool unlocked = false}) {
    return _Achievement(
      id: id,
      title: title,
      description: description,
      lvl: lvl,
      value: value,
      condition: condition,
      unlocked: unlocked,
    );
  }

  Achievement fromJson(Map<String, Object?> json) {
    return Achievement.fromJson(json);
  }
}

/// @nodoc
const $Achievement = _$AchievementTearOff();

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get lvl => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  int get condition => throw _privateConstructorUsedError;
  bool get unlocked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String description,
      int lvl,
      String value,
      int condition,
      bool unlocked});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res> implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  final Achievement _value;
  // ignore: unused_field
  final $Res Function(Achievement) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? lvl = freezed,
    Object? value = freezed,
    Object? condition = freezed,
    Object? unlocked = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      lvl: lvl == freezed
          ? _value.lvl
          : lvl // ignore: cast_nullable_to_non_nullable
              as int,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      condition: condition == freezed
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: unlocked == freezed
          ? _value.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AchievementCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(
          _Achievement value, $Res Function(_Achievement) then) =
      __$AchievementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String description,
      int lvl,
      String value,
      int condition,
      bool unlocked});
}

/// @nodoc
class __$AchievementCopyWithImpl<$Res> extends _$AchievementCopyWithImpl<$Res>
    implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(
      _Achievement _value, $Res Function(_Achievement) _then)
      : super(_value, (v) => _then(v as _Achievement));

  @override
  _Achievement get _value => super._value as _Achievement;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? lvl = freezed,
    Object? value = freezed,
    Object? condition = freezed,
    Object? unlocked = freezed,
  }) {
    return _then(_Achievement(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      lvl: lvl == freezed
          ? _value.lvl
          : lvl // ignore: cast_nullable_to_non_nullable
              as int,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      condition: condition == freezed
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: unlocked == freezed
          ? _value.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Achievement extends _Achievement {
  const _$_Achievement(
      {required this.id,
      required this.title,
      required this.description,
      required this.lvl,
      required this.value,
      required this.condition,
      this.unlocked = false})
      : super._();

  factory _$_Achievement.fromJson(Map<String, dynamic> json) =>
      _$$_AchievementFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int lvl;
  @override
  final String value;
  @override
  final int condition;
  @JsonKey(defaultValue: false)
  @override
  final bool unlocked;

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, lvl: $lvl, value: $value, condition: $condition, unlocked: $unlocked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Achievement &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lvl, lvl) || other.lvl == lvl) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, lvl, value, condition, unlocked);

  @JsonKey(ignore: true)
  @override
  _$AchievementCopyWith<_Achievement> get copyWith =>
      __$AchievementCopyWithImpl<_Achievement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AchievementToJson(this);
  }
}

abstract class _Achievement extends Achievement {
  const factory _Achievement(
      {required String id,
      required String title,
      required String description,
      required int lvl,
      required String value,
      required int condition,
      bool unlocked}) = _$_Achievement;
  const _Achievement._() : super._();

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$_Achievement.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get lvl;
  @override
  String get value;
  @override
  int get condition;
  @override
  bool get unlocked;
  @override
  @JsonKey(ignore: true)
  _$AchievementCopyWith<_Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}
