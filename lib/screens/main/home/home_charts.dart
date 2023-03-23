import 'package:danny/models/range.dart';
import 'package:danny/screens/main/home/home_data.dart';
import 'package:danny/widgets/charts/chart_card.dart';
import 'package:danny/widgets/charts/col_chart.dart';
import 'package:danny/widgets/charts/m_line_chart.dart';
import 'package:danny/widgets/charts/radar_chart.dart';
import 'package:danny/widgets/charts/stacked_chart.dart';
import 'package:flutter/material.dart';

class HomeCharts extends StatelessWidget {
  const HomeCharts({
    Key? key,
    required this.data,
    required this.range,
    required this.type,
  }) : super(key: key);

  final HomeData data;
  final Range range;
  final bool type;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return ChartCard(
              chart: RadarChart(data: data.radarData),
              info: 'Average Rating per Tracker',
            );

          case 1:
            return ChartCard(
              chart: StackedChart(data: data.stackedData),
              info: 'Rating Distribution per Tracker',
            );

          case 2:
            return ChartCard(
              chart: MLineChart(
                range: range,
                data: data.mlineData,
              ),
              info: 'Rating Evolution per Tracker',
            );

          case 3:
            return !type
                ? ChartCard(
                    chart: ColChart(data: data.colData),
                    info: 'Average Rating per Weekday',
                  )
                : const SizedBox();

          default:
            return const SizedBox();
        }
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
