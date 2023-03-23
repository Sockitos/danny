import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:danny/widgets/notifications/info_notification.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({
    Key? key,
    required this.chart,
    required this.info,
  }) : super(key: key);

  final Widget chart;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.55,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: AppBorders.borderM,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(5, 10),
                    color: AppColors.ksecondary.withOpacity(0.2),
                  ),
                ],
                color: Colors.white,
              ),
              child: chart,
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.kprimary,
                      content: InfoNotification(info),
                    ),
                  );
                },
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        offset: const Offset(2, 3),
                        color: AppColors.ksecondary.withOpacity(0.1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    CustomIcons.info,
                    color: AppColors.kprimary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
