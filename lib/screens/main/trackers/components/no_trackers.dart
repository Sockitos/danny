import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class NoTrackers extends StatelessWidget {
  const NoTrackers({
    Key? key,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 30, 30),
          child: InkWell(
            onTap: callback,
            borderRadius: BorderRadius.circular(35),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.kbackground,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: AppColors.kprimary, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kprimary.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(5, 7),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CustomIcons.mais,
                    color: AppColors.kprimary,
                    size: 64,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No trackers\nconfigured',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.ksecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
