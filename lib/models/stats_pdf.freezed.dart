// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stats_pdf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StatsPdfTearOff {
  const _$StatsPdfTearOff();

  _StatsPdf call({required DateTime date, required MemoryImage image}) {
    return _StatsPdf(
      date: date,
      image: image,
    );
  }
}

/// @nodoc
const $StatsPdf = _$StatsPdfTearOff();

/// @nodoc
mixin _$StatsPdf {
  DateTime get date => throw _privateConstructorUsedError;
  MemoryImage get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatsPdfCopyWith<StatsPdf> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsPdfCopyWith<$Res> {
  factory $StatsPdfCopyWith(StatsPdf value, $Res Function(StatsPdf) then) =
      _$StatsPdfCopyWithImpl<$Res>;
  $Res call({DateTime date, MemoryImage image});
}

/// @nodoc
class _$StatsPdfCopyWithImpl<$Res> implements $StatsPdfCopyWith<$Res> {
  _$StatsPdfCopyWithImpl(this._value, this._then);

  final StatsPdf _value;
  // ignore: unused_field
  final $Res Function(StatsPdf) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MemoryImage,
    ));
  }
}

/// @nodoc
abstract class _$StatsPdfCopyWith<$Res> implements $StatsPdfCopyWith<$Res> {
  factory _$StatsPdfCopyWith(_StatsPdf value, $Res Function(_StatsPdf) then) =
      __$StatsPdfCopyWithImpl<$Res>;
  @override
  $Res call({DateTime date, MemoryImage image});
}

/// @nodoc
class __$StatsPdfCopyWithImpl<$Res> extends _$StatsPdfCopyWithImpl<$Res>
    implements _$StatsPdfCopyWith<$Res> {
  __$StatsPdfCopyWithImpl(_StatsPdf _value, $Res Function(_StatsPdf) _then)
      : super(_value, (v) => _then(v as _StatsPdf));

  @override
  _StatsPdf get _value => super._value as _StatsPdf;

  @override
  $Res call({
    Object? date = freezed,
    Object? image = freezed,
  }) {
    return _then(_StatsPdf(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MemoryImage,
    ));
  }
}

/// @nodoc

class _$_StatsPdf implements _StatsPdf {
  const _$_StatsPdf({required this.date, required this.image});

  @override
  final DateTime date;
  @override
  final MemoryImage image;

  @override
  String toString() {
    return 'StatsPdf(date: $date, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatsPdf &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, image);

  @JsonKey(ignore: true)
  @override
  _$StatsPdfCopyWith<_StatsPdf> get copyWith =>
      __$StatsPdfCopyWithImpl<_StatsPdf>(this, _$identity);
}

abstract class _StatsPdf implements StatsPdf {
  const factory _StatsPdf(
      {required DateTime date, required MemoryImage image}) = _$_StatsPdf;

  @override
  DateTime get date;
  @override
  MemoryImage get image;
  @override
  @JsonKey(ignore: true)
  _$StatsPdfCopyWith<_StatsPdf> get copyWith =>
      throw _privateConstructorUsedError;
}
