import 'package:danny/constants/colors.dart';
import 'package:danny/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kbackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: AppColors.ksecondary.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Feedback.forTap(context);
                Navigator.pop(context, false);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Contact me',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      CustomIcons.mail,
                      size: 18,
                      color: AppColors.kprimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'jrnogueira@edu.ulisboa.pt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ksecondary.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      CustomIcons.phone,
                      size: 18,
                      color: AppColors.kprimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '+351 962 017 320',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ksecondary.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
