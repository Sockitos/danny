import 'package:freezed_annotation/freezed_annotation.dart';

part 'range.freezed.dart';

@freezed
class Range with _$Range {
  const factory Range(
    DateTime start,
    DateTime end,
  ) = _Range;
}
