import 'dart:math' as math;

import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/models/range.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/widgets/charts/line_chart.dart';
import 'package:danny/widgets/charts/ratings_axis.dart';
import 'package:danny/widgets/charts/week_axis.dart';
import 'package:flutter/material.dart';

class MainChart extends StatelessWidget {
  const MainChart({
    Key? key,
    required this.currentAverage,
    required this.percentage,
    required this.type,
    required this.currentRange,
    required this.currentRatings,
    required this.previousRange,
    required this.previousRatings,
  }) : super(key: key);

  final double currentAverage;
  final double percentage;
  final bool type;

  final Range currentRange;
  final List<List<Rating>> currentRatings;
  final Range previousRange;
  final List<List<Rating>> previousRatings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        currentAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          height: 1,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Transform.rotate(
                        angle: percentage < 0 ? 180 * math.pi / 180 : 0,
                        child: Icon(
                          CustomIcons.triangle,
                          color: percentage < 0
                              ? AppColors.kred
                              : AppColors.kgreen,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${percentage.abs().toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    type ? 'YOUR WEEKLY RATING' : 'YOUR MONTHLY RATING',
                    style: TextStyle(
                      height: 0.8,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Transform.translate(
                        offset: const Offset(0, 1),
                        child: const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'current',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 1),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'previous',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Stack(
          children: [
            const Positioned(
              left: 0,
              child: RatingsAxisAlt(),
            ),
            const Positioned(
              right: 0,
              child: RatingsAxisAlt(),
            ),
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  LineChart(
                    range: previousRange,
                    ratings: previousRatings,
                    average: true,
                    color: const Color(0xFF37b4f2),
                    marks: false,
                  ),
                  LineChart(
                    range: currentRange,
                    ratings: currentRatings,
                    average: true,
                    color: Colors.white,
                    marks: type,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WeekAxis(visible: type),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
