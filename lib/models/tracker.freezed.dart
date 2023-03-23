// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tracker _$TrackerFromJson(Map<String, dynamic> json) {
  return _Tracker.fromJson(json);
}

/// @nodoc
class _$TrackerTearOff {
  const _$TrackerTearOff();

  _Tracker call({required String id}) {
    return _Tracker(
      id: id,
    );
  }

  Tracker fromJson(Map<String, Object?> json) {
    return Tracker.fromJson(json);
  }
}

/// @nodoc
const $Tracker = _$TrackerTearOff();

/// @nodoc
mixin _$Tracker {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackerCopyWith<Tracker> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackerCopyWith<$Res> {
  factory $TrackerCopyWith(Tracker value, $Res Function(Tracker) then) =
      _$TrackerCopyWithImpl<$Res>;
  $Res call({String id});
}

/// @nodoc
class _$TrackerCopyWithImpl<$Res> implements $TrackerCopyWith<$Res> {
  _$TrackerCopyWithImpl(this._value, this._then);

  final Tracker _value;
  // ignore: unused_field
  final $Res Function(Tracker) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TrackerCopyWith<$Res> implements $TrackerCopyWith<$Res> {
  factory _$TrackerCopyWith(_Tracker value, $Res Function(_Tracker) then) =
      __$TrackerCopyWithImpl<$Res>;
  @override
  $Res call({String id});
}

/// @nodoc
class __$TrackerCopyWithImpl<$Res> extends _$TrackerCopyWithImpl<$Res>
    implements _$TrackerCopyWith<$Res> {
  __$TrackerCopyWithImpl(_Tracker _value, $Res Function(_Tracker) _then)
      : super(_value, (v) => _then(v as _Tracker));

  @override
  _Tracker get _value => super._value as _Tracker;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_Tracker(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tracker implements _Tracker {
  const _$_Tracker({required this.id});

  factory _$_Tracker.fromJson(Map<String, dynamic> json) =>
      _$$_TrackerFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'Tracker(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tracker &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  _$TrackerCopyWith<_Tracker> get copyWith =>
      __$TrackerCopyWithImpl<_Tracker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackerToJson(this);
  }
}

abstract class _Tracker implements Tracker {
  const factory _Tracker({required String id}) = _$_Tracker;

  factory _Tracker.fromJson(Map<String, dynamic> json) = _$_Tracker.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$TrackerCopyWith<_Tracker> get copyWith =>
      throw _privateConstructorUsedError;
}
