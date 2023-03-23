import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracker.freezed.dart';
part 'tracker.g.dart';

@freezed
class Tracker with _$Tracker {
  const factory Tracker({
    required String id,
  }) = _Tracker;

  factory Tracker.fromJson(Map<String, dynamic> json) =>
      _$TrackerFromJson(json);
}
