import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class RatingsAxis extends StatelessWidget {
  const RatingsAxis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            '5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '4',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '3',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingsAxisAlt extends StatelessWidget {
  const RatingsAxisAlt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 5,
              color: AppColors.kratings[4].withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Container(
              width: 5,
              color: AppColors.kratings[3].withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Container(
              width: 5,
              color: AppColors.kratings[2].withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Container(
              width: 5,
              color: AppColors.kratings[1].withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Container(
              width: 5,
              color: AppColors.kratings[0].withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
