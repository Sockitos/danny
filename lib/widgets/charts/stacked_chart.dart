import 'package:danny/constants/colors.dart';
import 'package:danny/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart extends StatelessWidget {
  const StackedChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ChartData<String, Map<int, int>>> data;

  DataLabelSettings _labelSettings() {
    return DataLabelSettings(
      isVisible: true,
      textStyle: TextStyle(
        color: Colors.black.withOpacity(0.75),
        fontFamily: 'Quicksand',
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onDataLabelRender: (args) {
        if (args.text == '0') args.text = ' ';
      },
      palette: AppColors.kratings,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(
          color: AppColors.ksecondary.withOpacity(0.75),
          fontFamily: 'Quicksand',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        isVisible: true,
      ),
      margin: const EdgeInsets.all(20),
      plotAreaBorderWidth: 0,
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none,
        isVisible: false,
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        iconHeight: 14,
        iconWidth: 14,
        textStyle: TextStyle(
          color: AppColors.ksecondary.withOpacity(0.75),
          fontFamily: 'Quicksand',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      series: <ChartSeries>[
        StackedBarSeries<ChartData<String, Map<int, int>>, String>(
          animationDuration: 600,
          name: '1',
          dataSource: data,
          legendIconType: LegendIconType.circle,
          xValueMapper: (sales, _) => sales.x,
          yValueMapper: (sales, _) => sales.y[1] ?? 0,
          spacing: 0,
          dataLabelSettings: _labelSettings(),
        ),
        StackedBarSeries<ChartData<String, Map<int, int>>, String>(
          animationDuration: 600,
          name: '2',
          dataSource: data,
          legendIconType: LegendIconType.circle,
          xValueMapper: (sales, _) => sales.x,
          yValueMapper: (sales, _) => sales.y[2] ?? 0,
          spacing: 0,
          dataLabelSettings: _labelSettings(),
        ),
        StackedBarSeries<ChartData<String, Map<int, int>>, String>(
          animationDuration: 600,
          name: '3',
          dataSource: data,
          legendIconType: LegendIconType.circle,
          xValueMapper: (sales, _) => sales.x,
          yValueMapper: (sales, _) => sales.y[3] ?? 0,
          spacing: 0,
          dataLabelSettings: _labelSettings(),
        ),
        StackedBarSeries<ChartData<String, Map<int, int>>, String>(
          animationDuration: 600,
          name: '4',
          dataSource: data,
          legendIconType: LegendIconType.circle,
          xValueMapper: (sales, _) => sales.x,
          yValueMapper: (sales, _) => sales.y[4] ?? 0,
          spacing: 0,
          dataLabelSettings: _labelSettings(),
        ),
        StackedBarSeries<ChartData<String, Map<int, int>>, String>(
          animationDuration: 600,
          name: '5',
          dataSource: data,
          legendIconType: LegendIconType.circle,
          xValueMapper: (sales, _) => sales.x,
          yValueMapper: (sales, _) => sales.y[5] ?? 0,
          spacing: 0,
          dataLabelSettings: _labelSettings(),
        )
      ],
    );
  }
}
