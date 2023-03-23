// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chart_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChartDataTearOff {
  const _$ChartDataTearOff();

  _ChartData<X, Y> call<X, Y>(X x, Y y) {
    return _ChartData<X, Y>(
      x,
      y,
    );
  }
}

/// @nodoc
const $ChartData = _$ChartDataTearOff();

/// @nodoc
mixin _$ChartData<X, Y> {
  X get x => throw _privateConstructorUsedError;
  Y get y => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChartDataCopyWith<X, Y, ChartData<X, Y>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataCopyWith<X, Y, $Res> {
  factory $ChartDataCopyWith(
          ChartData<X, Y> value, $Res Function(ChartData<X, Y>) then) =
      _$ChartDataCopyWithImpl<X, Y, $Res>;
  $Res call({X x, Y y});
}

/// @nodoc
class _$ChartDataCopyWithImpl<X, Y, $Res>
    implements $ChartDataCopyWith<X, Y, $Res> {
  _$ChartDataCopyWithImpl(this._value, this._then);

  final ChartData<X, Y> _value;
  // ignore: unused_field
  final $Res Function(ChartData<X, Y>) _then;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as X,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as Y,
    ));
  }
}

/// @nodoc
abstract class _$ChartDataCopyWith<X, Y, $Res>
    implements $ChartDataCopyWith<X, Y, $Res> {
  factory _$ChartDataCopyWith(
          _ChartData<X, Y> value, $Res Function(_ChartData<X, Y>) then) =
      __$ChartDataCopyWithImpl<X, Y, $Res>;
  @override
  $Res call({X x, Y y});
}

/// @nodoc
class __$ChartDataCopyWithImpl<X, Y, $Res>
    extends _$ChartDataCopyWithImpl<X, Y, $Res>
    implements _$ChartDataCopyWith<X, Y, $Res> {
  __$ChartDataCopyWithImpl(
      _ChartData<X, Y> _value, $Res Function(_ChartData<X, Y>) _then)
      : super(_value, (v) => _then(v as _ChartData<X, Y>));

  @override
  _ChartData<X, Y> get _value => super._value as _ChartData<X, Y>;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
  }) {
    return _then(_ChartData<X, Y>(
      x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as X,
      y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as Y,
    ));
  }
}

/// @nodoc

class _$_ChartData<X, Y> implements _ChartData<X, Y> {
  const _$_ChartData(this.x, this.y);

  @override
  final X x;
  @override
  final Y y;

  @override
  String toString() {
    return 'ChartData<$X, $Y>(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChartData<X, Y> &&
            const DeepCollectionEquality().equals(other.x, x) &&
            const DeepCollectionEquality().equals(other.y, y));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(x),
      const DeepCollectionEquality().hash(y));

  @JsonKey(ignore: true)
  @override
  _$ChartDataCopyWith<X, Y, _ChartData<X, Y>> get copyWith =>
      __$ChartDataCopyWithImpl<X, Y, _ChartData<X, Y>>(this, _$identity);
}

abstract class _ChartData<X, Y> implements ChartData<X, Y> {
  const factory _ChartData(X x, Y y) = _$_ChartData<X, Y>;

  @override
  X get x;
  @override
  Y get y;
  @override
  @JsonKey(ignore: true)
  _$ChartDataCopyWith<X, Y, _ChartData<X, Y>> get copyWith =>
      throw _privateConstructorUsedError;
}
