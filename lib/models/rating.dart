import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

DateTime fromMillis(int millis) =>
    DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true).toLocal();
int toMillis(DateTime date) => date.toUtc().millisecondsSinceEpoch;

@freezed
class Rating with _$Rating {
  const factory Rating({
    required String id,
    required String tracker,
    required int rating,
    @JsonKey(fromJson: fromMillis, toJson: toMillis)
        required DateTime timestamp,
    @Default('') String imageUrl1,
    @Default('') String imageUrl2,
    @Default('') String imageUrl3,
  }) = _Rating;
  const Rating._();

  factory Rating.fromBLEJson(Map<dynamic, dynamic> value) {
    final timestamp = value['t'] as String;
    final format = DateFormat('dd/MM/yyyy HH:mm');

    return Rating(
      id: const Uuid().v1(),
      tracker: value['m'] as String,
      rating: value['r'] as int,
      timestamp: format.parse(timestamp, true).toLocal(),
    );
  }

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  DateTime get auxTimestamp => timestamp.subtract(const Duration(hours: 6));
}
