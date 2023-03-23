import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.callback,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final VoidCallback callback;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: InkWell(
        onTap: callback,
        borderRadius: AppBorders.borderM,
        child: Ink(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: AppColors.ksecondary.withOpacity(0.1),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kprimary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
