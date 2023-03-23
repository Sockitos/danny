import 'package:danny/screens/main/trackers/tracker/tracker_data.dart';
import 'package:danny/widgets/charts/chart_card.dart';
import 'package:danny/widgets/charts/col_chart.dart';
import 'package:danny/widgets/charts/histo_chart.dart';
import 'package:flutter/material.dart';

class TrackerCharts extends StatelessWidget {
  const TrackerCharts({
    Key? key,
    required this.data,
    required this.type,
  }) : super(key: key);

  final TrackerData data;
  final bool type;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return ChartCard(
              chart: HistoChart(data: data.histoData),
              info: 'Rating Distribution',
            );

          case 1:
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
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
