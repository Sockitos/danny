import 'package:danny/constants/colors.dart';
import 'package:danny/widgets/shadowed_box.dart';
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.light = false,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.80,
      child: ShadowedBox(
        borderRadius: BorderRadius.circular(45),
        shadowColor: light
            ? AppColors.ksecondary.withOpacity(0.5)
            : AppColors.kprimary.withOpacity(0.5),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            backgroundColor: light ? Colors.white : AppColors.kprimary,
            surfaceTintColor: Colors.red,
            fixedSize: const Size.fromHeight(56),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: light ? AppColors.kprimary : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
