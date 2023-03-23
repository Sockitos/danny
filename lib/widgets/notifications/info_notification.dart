import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class InfoNotification extends StatelessWidget {
  const InfoNotification(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.info,
          color: Colors.white,
          size: 22,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
