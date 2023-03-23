import 'dart:async';

import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/screens/main/home/home_data.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/charts/chart_card.dart';
import 'package:danny/widgets/charts/col_chart.dart';
import 'package:danny/widgets/charts/main_chart.dart';
import 'package:danny/widgets/charts/radar_chart.dart';
import 'package:danny/widgets/charts/stacked_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WellbeingGeneration extends StatefulWidget {
  const WellbeingGeneration({
    Key? key,
    required this.type,
    required this.range,
    required this.pageController,
  }) : super(key: key);

  final bool type;
  final Range range;
  final PageController pageController;

  @override
  _WellbeingGenerationState createState() => _WellbeingGenerationState();
}

class _WellbeingGenerationState extends State<WellbeingGeneration> {
  List<Rating> ratings = [];
  HomeData data = HomeData();

  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final ratingsStream = db.ratingsStream();
    subscription = ratingsStream.listen((ratings) {
      this.ratings = ratings;
      _update();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _update() {
    setState(() {
      data.updateData(ratings, widget.range, widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: widget.type ? 3 : 4,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return MainChart(
              currentAverage: data.currentAverage,
              percentage: data.percentage,
              type: widget.type,
              currentRange: widget.range,
              currentRatings: data.averageCurrentRatings,
              previousRange: previous(widget.type, widget.range),
              previousRatings: data.averagePreviousRatings,
            );
          case 1:
            return Column(
              children: [
                const Text(
                  'Average Rating per Tracker',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ChartCard(
                  chart: RadarChart(data: data.radarData),
                  info: 'Average Rating per Tracker',
                ),
              ],
            );
          case 2:
            return Column(
              children: [
                const Text(
                  'Rating Distribution per Tracker',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ChartCard(
                  chart: StackedChart(data: data.stackedData),
                  info: 'Rating Distribution per Tracker',
                ),
              ],
            );
          case 3:
            return Column(
              children: [
                const Text(
                  'Average Rating per Weekday',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ChartCard(
                  chart: ColChart(data: data.colData),
                  info: 'Average Rating per Weekday',
                ),
              ],
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
