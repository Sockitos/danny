// ignore_for_file: avoid_positional_boolean_parameters

import 'package:danny/models/range.dart';

extension DateUtils on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);
}

Range fixRange(Range range) {
  return Range(
    DateTime(
      range.start.year,
      range.start.month,
      range.start.day,
      range.start.hour,
      range.start.minute,
      range.start.second,
    ),
    DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
      range.end.hour,
      range.end.minute,
      range.end.second,
    ),
  );
}

Range unfixRange(Range range) {
  return Range(
    DateTime.utc(
      range.start.year,
      range.start.month,
      range.start.day,
      range.start.hour,
      range.start.minute,
      range.start.second,
    ),
    DateTime.utc(
      range.end.year,
      range.end.month,
      range.end.day,
      range.end.hour,
      range.end.minute,
      range.end.second,
    ),
  );
}

Range getWeekRange() {
  const monday = 1;
  var now = DateTime.now().toUtc();

  while (now.weekday != monday) {
    now = now.subtract(const Duration(days: 1));
  }
  now = DateTime.utc(now.year, now.month, now.day);
  var then = now.add(const Duration(days: 6));
  then = DateTime.utc(then.year, then.month, then.day, 23, 59, 59);
  return fixRange(Range(now, then));
}

Range getMonthRange() {
  var now = DateTime.now().toUtc();
  now = DateTime.utc(now.year, now.month);
  final then = DateTime.utc(now.year, now.month + 1, 0, 23, 59, 59);
  return fixRange(Range(now, then));
}

Range next(bool type, Range range) {
  DateTime start;
  DateTime end;
  final auxRange = unfixRange(range);
  if (type) {
    start = auxRange.start.add(const Duration(days: 7)).toUtc();
    end = auxRange.end.add(const Duration(days: 7)).toUtc();
  } else {
    start = DateTime.utc(auxRange.start.year, auxRange.start.month + 1);
    end = DateTime.utc(auxRange.start.year, auxRange.start.month + 2, 0);
  }
  return fixRange(Range(start, end));
}

Range previous(bool type, Range range) {
  DateTime start;
  DateTime end;
  final auxRange = unfixRange(range);
  if (type) {
    start = auxRange.start.subtract(const Duration(days: 7)).toUtc();
    end = auxRange.end.subtract(const Duration(days: 7)).toUtc();
  } else {
    start = DateTime.utc(auxRange.start.year, auxRange.start.month - 1);
    end = DateTime.utc(auxRange.start.year, auxRange.start.month, 0);
  }
  return fixRange(Range(start, end));
}
