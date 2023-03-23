import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
    required this.count,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final int count;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Icon(
          icon,
          size: 66,
          color: AppColors.ksecondary.withOpacity(0.03),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.ksecondary,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.ksecondary.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
