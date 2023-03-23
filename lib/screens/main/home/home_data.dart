// ignore_for_file: type_annotate_public_apis

import 'package:danny/models/chart_data.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/utils/data_utils.dart';
import 'package:danny/utils/date_utils.dart';

class HomeData {
  final dailyRatings = <DateTime, List<Rating>>{};

  var averageCurrentRatings = <List<Rating>>[];
  var averagePreviousRatings = <List<Rating>>[];

  var currentAverage = 2.5;
  var previousAverage = 2.5;
  var percentage = 0.0;

  var radarData = <ChartData<String, num>>[];
  var stackedData = <ChartData<String, Map<int, int>>>[];
  var colData = <ChartData<String, num>>[];
  var mlineData = <String, List<Rating>>{};

  void updateData(List<Rating> ratings, Range range, bool type) {
    dailyRatings.clear();
    for (final r in ratings) {
      final date = DateTime(
        r.auxTimestamp.year,
        r.auxTimestamp.month,
        r.auxTimestamp.day,
      );
      if (dailyRatings.containsKey(date)) {
        dailyRatings[date]!.add(r);
      } else {
        dailyRatings[date] = [r];
      }
    }

    var min = range.start.subtract(const Duration(seconds: 1));
    var max = range.end.add(const Duration(seconds: 1));
    var inRange = false;

    List<Rating>? afterOOCRRating;
    List<Rating>? beforeOOPRRating;

    final currentRatings = ratings
        .where(
          (r) => r.auxTimestamp.isAfter(min) && r.auxTimestamp.isBefore(max),
        )
        .toList();

    averageCurrentRatings = dailyRatings.entries
        .where((entry) {
          if (entry.key.isAfter(min) && entry.key.isBefore(max)) {
            inRange = true;
            return true;
          } else {
            if (inRange) {
              afterOOCRRating = entry.value;
              inRange = false;
            }
            return false;
          }
        })
        .map((e) => e.value)
        .toList();

    final pre = previous(type, range);
    min = pre.start.subtract(const Duration(seconds: 1));
    max = pre.end.add(const Duration(seconds: 1));
    inRange = false;

    averagePreviousRatings = dailyRatings.entries
        .where((entry) {
          if (entry.key.isAfter(min) && entry.key.isBefore(max)) {
            inRange = true;
            return true;
          } else {
            if (!inRange) {
              beforeOOPRRating = entry.value;
            }
            return false;
          }
        })
        .map((e) => e.value)
        .toList();

    currentAverage = getAverage(averageCurrentRatings);
    previousAverage = getAverage(averagePreviousRatings);
    percentage = (currentAverage - previousAverage) / previousAverage * 100;

    radarData = getRadarData(currentRatings);
    stackedData = getStackedData(currentRatings);
    colData = getColData(currentRatings);
    mlineData = getMLineData(currentRatings);

    List<Rating>? lastPreviousRating;

    if (averagePreviousRatings.isNotEmpty) {
      lastPreviousRating = averagePreviousRatings.last;
      if (beforeOOPRRating != null) {
        averagePreviousRatings = [beforeOOPRRating!, ...averagePreviousRatings];
      }

      if (averageCurrentRatings.isNotEmpty) {
        averagePreviousRatings = [
          ...averagePreviousRatings,
          averageCurrentRatings.first
        ];
      }
    }

    if (averageCurrentRatings.isNotEmpty) {
      if (lastPreviousRating != null) {
        averageCurrentRatings = [lastPreviousRating, ...averageCurrentRatings];
      }
      if (afterOOCRRating != null) {
        averageCurrentRatings = [...averageCurrentRatings, afterOOCRRating!];
      }
    }
  }
}
