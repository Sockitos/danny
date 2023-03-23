import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/models/range.dart';
import 'package:danny/utils/date_utils.dart';
import 'package:danny/widgets/step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RangeSelector extends StatelessWidget {
  const RangeSelector({
    Key? key,
    required this.type,
    required this.range,
    required this.changeType,
    required this.changeRange,
    this.light = true,
  }) : super(key: key);

  final bool type;
  final Range range;
  final ValueChanged<bool> changeType;
  final ValueChanged<Range> changeRange;
  final bool light;
  static DateFormat dateFormat = DateFormat('MMM d.');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderM,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(5, 10),
            color: light
                ? AppColors.ksecondary.withOpacity(0.2)
                : AppColors.kprimary.withOpacity(0.5),
          ),
        ],
        color: light ? Colors.white : AppColors.kprimary,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  (type ? 'This week' : 'This month').toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: light ? AppColors.ksecondary : Colors.white,
                  ),
                ),
                Text(
                  '${dateFormat.format(range.start)} - ${dateFormat.format(range.end)}'
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: light
                        ? AppColors.ksecondary.withOpacity(0.5)
                        : Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            StepIndicator(
              horizontal: true,
              light: !light,
              callback: (value) {
                if (value == 1) {
                  changeRange(next(type, range));
                } else {
                  changeRange(previous(type, range));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
