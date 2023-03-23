import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class ErrorNotification extends StatelessWidget {
  const ErrorNotification(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.warning,
          color: AppColors.kprimary,
          size: 22,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            color: AppColors.ksecondary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
