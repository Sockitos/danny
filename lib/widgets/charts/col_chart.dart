import 'package:danny/constants/colors.dart';
import 'package:danny/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColChart extends StatelessWidget {
  const ColChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ChartData<String, num>> data;

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
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 5.5,
        numberFormat: NumberFormat('0.0'),
        isVisible: false,
      ),
      margin: const EdgeInsets.all(20),
      plotAreaBorderWidth: 0,
      series: [
        ColumnSeries<ChartData<String, num>, String>(
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
