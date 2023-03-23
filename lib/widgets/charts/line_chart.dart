import 'package:animations/animations.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/dialogs/list_ratings.dart';
import 'package:danny/widgets/dialogs/rating_details.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({
    Key? key,
    required this.range,
    required this.ratings,
    this.average = false,
    required this.color,
    this.marks = true,
  }) : super(key: key);

  final Range range;
  final List<List<Rating>> ratings;
  final bool average;
  final Color color;
  final bool marks;

  void showMarkerInfo(BuildContext context, List<Rating> data) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => data.length > 1
          ? ListRatings(ratings: data)
          : RatingDetails(rating: data.first),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  double _getAverage(List<Rating> ratings) {
    if (ratings.isEmpty) return 0;
    var sum = 0.0;
    for (final r in ratings) {
      sum += r.rating;
    }
    return sum / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        minimum: range.start.subtract(const Duration(hours: 12)),
        maximum: DateTime(range.end.year, range.end.month, range.end.day, 12),
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        minimum: 0.5,
        maximum: 5.5,
        isVisible: false,
      ),
      palette: [color],
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      tooltipBehavior: TooltipBehavior(
        activationMode: ActivationMode.singleTap,
        enable: true,
        opacity: 0,
        duration: 1000,
        builder: (dynamic a, dynamic b, dynamic c, pointIndex, _) {
          Future.delayed(const Duration(milliseconds: 5), () {
            Feedback.forTap(context);
            showMarkerInfo(
              context,
              ratings[pointIndex],
            );
          });
          return const SizedBox();
        },
      ),
      series: [
        SplineSeries<List<Rating>, DateTime>(
          animationDuration: 600,
          width: 7,
          dataSource: ratings,
          xValueMapper: (rs, _) => rs.first.auxTimestamp.dateOnly,
          yValueMapper: (rs, _) => _getAverage(rs),
          markerSettings: MarkerSettings(
            isVisible: marks,
            height: 12,
            width: 12,
          ),
        ),
      ],
    );
  }
}
