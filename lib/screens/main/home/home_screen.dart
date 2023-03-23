import 'dart:async';

import 'package:animations/animations.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/screens/main/home/home_charts.dart';
import 'package:danny/screens/main/home/home_data.dart';
import 'package:danny/services/firestore_database.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/charts/main_chart.dart';
import 'package:danny/widgets/danny_avatar.dart';
import 'package:danny/widgets/dialogs/date_picker.dart';
import 'package:danny/widgets/range_selector.dart';
import 'package:danny/widgets/switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool type = true;
  late Range range;
  List<Rating> ratings = [];
  HomeData data = HomeData();
  late StreamSubscription subscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    range = getWeekRange();
    super.initState();

    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    subscription = db.ratingsStream().listen((ratings) {
      this.ratings = ratings;
      _update();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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

  void _showDatePicker(
    BuildContext context,
    Map<DateTime, List<Rating>> events,
  ) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DatePicker(events: events),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  void _update() => setState(() => data.updateData(ratings, range, type));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final displayName = Provider.of<UserData>(context).displayName;

    return SingleChildScrollView(
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
            right: 20,
            top: 20,
            child: ClipOval(
              child: Material(
                color: Colors.black.withOpacity(0.1), // button color
                child: InkWell(
                  child: const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      CustomIcons.ready,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => _showDatePicker(context, data.dailyRatings),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const DannyAvatar(glow: true),
                Text(
                  'Hey $displayName!',
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
                HomeCharts(data: data, range: range, type: type),
                SizedBox(height: type ? 0 : 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
