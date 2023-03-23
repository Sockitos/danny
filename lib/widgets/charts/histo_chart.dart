import 'package:danny/constants/colors.dart';
import 'package:danny/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoChart extends StatelessWidget {
  const HistoChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ChartData<int, num>> data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      palette: const [AppColors.kprimary],
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          color: AppColors.ksecondary,
          fontFamily: 'Quicksand',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        isVisible: true,
      ),
      margin: const EdgeInsets.all(20),
      plotAreaBorderWidth: 0,
      primaryYAxis: NumericAxis(
        isVisible: false,
      ),
      series: [
        BarSeries<ChartData<int, num>, int>(
          animationDuration: 600,
          dataSource: data,
          xValueMapper: (d, _) => d.x,
          yValueMapper: (d, _) => d.y,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
