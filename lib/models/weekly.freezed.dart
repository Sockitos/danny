// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weekly.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Weekly _$WeeklyFromJson(Map<String, dynamic> json) {
  return _Weekly.fromJson(json);
}

/// @nodoc
class _$WeeklyTearOff {
  const _$WeeklyTearOff();

  _Weekly call(
      {required String question,
      required String challenge,
      required String recommendation}) {
    return _Weekly(
      question: question,
      challenge: challenge,
      recommendation: recommendation,
    );
  }

  Weekly fromJson(Map<String, Object?> json) {
    return Weekly.fromJson(json);
  }
}

/// @nodoc
const $Weekly = _$WeeklyTearOff();

/// @nodoc
mixin _$Weekly {
  String get question => throw _privateConstructorUsedError;
  String get challenge => throw _privateConstructorUsedError;
  String get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeeklyCopyWith<Weekly> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyCopyWith<$Res> {
  factory $WeeklyCopyWith(Weekly value, $Res Function(Weekly) then) =
      _$WeeklyCopyWithImpl<$Res>;
  $Res call({String question, String challenge, String recommendation});
}

/// @nodoc
class _$WeeklyCopyWithImpl<$Res> implements $WeeklyCopyWith<$Res> {
  _$WeeklyCopyWithImpl(this._value, this._then);

  final Weekly _value;
  // ignore: unused_field
  final $Res Function(Weekly) _then;

  @override
  $Res call({
    Object? question = freezed,
    Object? challenge = freezed,
    Object? recommendation = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: challenge == freezed
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: recommendation == freezed
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WeeklyCopyWith<$Res> implements $WeeklyCopyWith<$Res> {
  factory _$WeeklyCopyWith(_Weekly value, $Res Function(_Weekly) then) =
      __$WeeklyCopyWithImpl<$Res>;
  @override
  $Res call({String question, String challenge, String recommendation});
}

/// @nodoc
class __$WeeklyCopyWithImpl<$Res> extends _$WeeklyCopyWithImpl<$Res>
    implements _$WeeklyCopyWith<$Res> {
  __$WeeklyCopyWithImpl(_Weekly _value, $Res Function(_Weekly) _then)
      : super(_value, (v) => _then(v as _Weekly));

  @override
  _Weekly get _value => super._value as _Weekly;

  @override
  $Res call({
    Object? question = freezed,
    Object? challenge = freezed,
    Object? recommendation = freezed,
  }) {
    return _then(_Weekly(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: challenge == freezed
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String,
      recommendation: recommendation == freezed
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Weekly implements _Weekly {
  const _$_Weekly(
      {required this.question,
      required this.challenge,
      required this.recommendation});

  factory _$_Weekly.fromJson(Map<String, dynamic> json) =>
      _$$_WeeklyFromJson(json);

  @override
  final String question;
  @override
  final String challenge;
  @override
  final String recommendation;

  @override
  String toString() {
    return 'Weekly(question: $question, challenge: $challenge, recommendation: $recommendation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Weekly &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, question, challenge, recommendation);

  @JsonKey(ignore: true)
  @override
  _$WeeklyCopyWith<_Weekly> get copyWith =>
      __$WeeklyCopyWithImpl<_Weekly>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeeklyToJson(this);
  }
}

abstract class _Weekly implements Weekly {
  const factory _Weekly(
      {required String question,
      required String challenge,
      required String recommendation}) = _$_Weekly;

  factory _Weekly.fromJson(Map<String, dynamic> json) = _$_Weekly.fromJson;

  @override
  String get question;
  @override
  String get challenge;
  @override
  String get recommendation;
  @override
  @JsonKey(ignore: true)
  _$WeeklyCopyWith<_Weekly> get copyWith => throw _privateConstructorUsedError;
}
