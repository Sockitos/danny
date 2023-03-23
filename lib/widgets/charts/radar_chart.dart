import 'package:danny/constants/colors.dart';
import 'package:danny/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadarChart extends StatelessWidget {
  const RadarChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ChartData<String, num>> data;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      palette: AppColors.kpallete,
      legend: Legend(
        isVisible: true,
        iconHeight: 14,
        iconWidth: 14,
        textStyle: TextStyle(
          color: AppColors.ksecondary.withOpacity(0.75),
          fontFamily: 'Quicksand',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      margin: const EdgeInsets.only(right: 5),
      series: [
        RadialBarSeries<ChartData<String, num>, String>(
          animationDuration: 600,
          legendIconType: LegendIconType.circle,
          maximumValue: 4,
          dataSource: data,
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.y - 1,
          dataLabelMapper: (data, _) => data.y.toStringAsFixed(1),
          cornerStyle: CornerStyle.bothCurve,
          gap: 4.toString(),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              color: AppColors.ksecondary.withOpacity(0.75),
              fontFamily: 'Quicksand',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
