import 'dart:math';

import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    required this.callback,
    this.horizontal = false,
    this.light = true,
  }) : super(key: key);

  final ValueChanged<int> callback;
  final bool horizontal;
  final bool light;

  void _previous() => callback(-1);
  void _forward() => callback(1);

  List<Widget> _steppers() {
    final color = light ? Colors.white : AppColors.ksecondary;
    return [
      Transform.rotate(
        angle: horizontal ? -pi / 2 : 0,
        child: IconButton(
          iconSize: 16,
          icon: const Icon(CustomIcons.arrow_up, size: 18),
          color: color.withOpacity(0.75),
          onPressed: _previous,
        ),
      ),
      const SizedBox(width: 8),
      Transform.rotate(
        angle: horizontal ? -pi / 2 : 0,
        child: IconButton(
          iconSize: 16,
          icon: const Icon(CustomIcons.arrow_down, size: 18),
          color: color.withOpacity(0.75),
          onPressed: _forward,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: horizontal
          ? Row(children: _steppers())
          : Column(children: _steppers()),
    );
  }
}
