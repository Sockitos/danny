import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly.freezed.dart';
part 'weekly.g.dart';

@freezed
class Weekly with _$Weekly {
  const factory Weekly({
    required String question,
    required String challenge,
    required String recommendation,
  }) = _Weekly;

  factory Weekly.fromJson(Map<String, dynamic> json) => _$WeeklyFromJson(json);
}
