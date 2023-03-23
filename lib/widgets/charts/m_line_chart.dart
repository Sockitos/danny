import 'package:danny/constants/colors.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MLineChart extends StatelessWidget {
  const MLineChart({
    Key? key,
    required this.range,
    required this.data,
  }) : super(key: key);

  final Range range;
  final Map<String, List<Rating>> data;

  List<SplineSeries<Rating, DateTime>> _splines() {
    final splines = <SplineSeries<Rating, DateTime>>[];
    data.forEach((k, v) {
      splines.add(
        SplineSeries<Rating, DateTime>(
          name: k,
          legendIconType: LegendIconType.circle,
          animationDuration: 600,
          width: 4,
          dataSource: v,
          xValueMapper: (r, _) => r.timestamp,
          yValueMapper: (r, _) => r.rating,
        ),
      );
    });
    return splines;
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        minimum: range.start,
        maximum: DateTime(range.end.year, range.end.month, range.end.day),
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        minimum: 0.5,
        maximum: 5.5,
        isVisible: false,
      ),
      palette: AppColors.kpallete,
      legend: Legend(
        padding: 4,
        itemPadding: 6,
        isVisible: true,
        position: LegendPosition.bottom,
        iconHeight: 12,
        iconWidth: 12,
        textStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.ksecondary.withOpacity(0.75),
        ),
      ),
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      series: _splines(),
    );
  }
}
