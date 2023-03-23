import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  const SideButton({
    Key? key,
    required this.callback,
    required this.icon,
  }) : super(key: key);

  final VoidCallback callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 40,
      child: InkWell(
        onTap: callback,
        borderRadius: AppBorders.borderS,
        child: Ink(
          padding: const EdgeInsets.fromLTRB(24, 12, 30, 12),
          decoration: BoxDecoration(
            color: AppColors.kprimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(-5, 10),
                color: AppColors.kprimary.withOpacity(0.3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
