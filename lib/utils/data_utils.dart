import 'package:danny/models/chart_data.dart';
import 'package:danny/models/rating.dart';

List<ChartData<String, num>> getRadarData(List<Rating> ratings) {
  final radarData = <ChartData<String, num>>[];
  final radarCounters = <String, List<int>>{};
  for (final r in ratings) {
    if (radarCounters.containsKey(r.tracker)) {
      radarCounters[r.tracker]!.add(r.rating);
    } else {
      radarCounters[r.tracker] = [r.rating];
    }
  }
  radarCounters.forEach(
    (k, v) => radarData.add(
      ChartData<String, num>(
        k,
        v.length != 1 ? v.reduce((a, b) => a + b) / v.length : v[0],
      ),
    ),
  );
  return radarData..sort((a, b) => a.y.compareTo(b.y));
}

List<ChartData<String, Map<int, int>>> getStackedData(List<Rating> ratings) {
  final stackedData = <ChartData<String, Map<int, int>>>[];
  final stackedCounters = <String, Map<int, int>>{};
  for (final r in ratings) {
    if (stackedCounters.containsKey(r.tracker)) {
      if (stackedCounters[r.tracker]!.containsKey(r.rating)) {
        stackedCounters[r.tracker]![r.rating] =
            stackedCounters[r.tracker]![r.rating]! + 1;
      } else {
        stackedCounters[r.tracker]![r.rating] = 1;
      }
    } else {
      stackedCounters[r.tracker] = <int, int>{};
      stackedCounters[r.tracker]![r.rating] = 1;
    }
  }
  stackedCounters.forEach(
    (k, v) => stackedData.add(ChartData<String, Map<int, int>>(k, v)),
  );
  return stackedData;
}

Map<String, List<Rating>> getMLineData(List<Rating> ratings) {
  final mlineData = <String, List<Rating>>{};
  for (final r in ratings) {
    if (mlineData.containsKey(r.tracker)) {
      mlineData[r.tracker]!.add(r);
    } else {
      mlineData[r.tracker] = [r];
    }
  }
  return mlineData;
}

List<ChartData<int, int>> getHistoData(List<Rating> ratings) {
  final histoCounters = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  final histoData = <ChartData<int, int>>[];
  for (final r in ratings) {
    histoCounters[r.rating] = (histoCounters[r.rating] ?? 0) + 1;
  }
  histoCounters.forEach((k, v) => histoData.add(ChartData<int, int>(k, v)));
  return histoData;
}

List<ChartData<String, num>> getColData(List<Rating> ratings) {
  final days = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final colData = <ChartData<String, num>>[];
  final auxColData = <String, List<int>>{
    'Mon': [],
    'Tue': [],
    'Wed': [],
    'Thu': [],
    'Fri': [],
    'Sat': [],
    'Sun': []
  };
  for (final r in ratings) {
    if (auxColData.containsKey(days[r.auxTimestamp.weekday - 1])) {
      auxColData[days[r.auxTimestamp.weekday - 1]]!.add(r.rating);
    } else {
      auxColData[days[r.auxTimestamp.weekday - 1]] = [r.rating];
    }
  }
  auxColData.forEach((k, v) {
    colData.add(
      ChartData<String, num>(
        k,
        v.fold<num>(0, (a, b) => a + b) / (v.isEmpty ? 1 : v.length),
      ),
    );
  });
  return colData;
}

double getAverage(List<List<Rating>> ratings) {
  if (ratings.isNotEmpty) {
    var sum = 0.0;
    for (final rs in ratings) {
      sum += _getAverage(rs);
    }
    return sum / ratings.length;
  }
  return 2.5;
}

double _getAverage(List<Rating> ratings) {
  if (ratings.isNotEmpty) {
    var sum = 0;
    for (final r in ratings) {
      sum += r.rating;
    }
    return sum / ratings.length;
  }
  return 2.5;
}
