import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/screens/main/trackers/tracker/tracker_charts.dart';
import 'package:danny/screens/main/trackers/tracker/tracker_data.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/charts/main_chart.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/range_selector.dart';
import 'package:danny/widgets/switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({
    Key? key,
    required this.tracker,
  }) : super(key: key);

  final Tracker tracker;

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  bool type = true;
  late Range range;
  List<Rating> ratings = [];
  TrackerData data = TrackerData();

  @override
  void initState() {
    range = getWeekRange();
    super.initState();

    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    db.ratingsByTrackerStream(widget.tracker).listen((ratings) {
      this.ratings = ratings;
      _update();
    });
  }

  void _changeRange(Range newRange) {
    range = newRange;
    _update();
  }

  void _changeType(bool option) {
    type = option;
    if (type) {
      range = getWeekRange();
    } else {
      range = getMonthRange();
    }
    _update();
  }

  void _update() => setState(() => data.updateData(ratings, range, type));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 660,
                decoration: const BoxDecoration(
                  color: AppColors.kprimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(150, 30),
                    bottomRight: Radius.elliptical(150, 30),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      CustomIcons.back,
                      color: Colors.white.withOpacity(0.5),
                      size: 24,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const DannyAvatar(glow: true),
                    Text(
                      widget.tracker.id,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Switcher(callback: _changeType),
                    const SizedBox(height: 15),
                    MainChart(
                      currentAverage: data.currentAverage,
                      percentage: data.percentage,
                      type: type,
                      currentRange: range,
                      currentRatings: data.averageCurrentRatings,
                      previousRange: previous(type, range),
                      previousRatings: data.averagePreviousRatings,
                    ),
                    const SizedBox(height: 12),
                    RangeSelector(
                      type: type,
                      range: range,
                      changeType: _changeType,
                      changeRange: _changeRange,
                    ),
                    TrackerCharts(data: data, type: type),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
