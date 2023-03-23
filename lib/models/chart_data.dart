import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data.freezed.dart';

@freezed
class ChartData<X, Y> with _$ChartData<X, Y> {
  const factory ChartData(
    X x,
    Y y,
  ) = _ChartData;
}
