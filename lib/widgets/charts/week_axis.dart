import 'package:flutter/material.dart';

class WeekAxis extends StatelessWidget {
  const WeekAxis({
    Key? key,
    required this.visible,
  }) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'M',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'T',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'W',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'T',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'F',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'S',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'S',
          style: TextStyle(
            color: Colors.black.withOpacity(visible ? 0.2 : 0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
