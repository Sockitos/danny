import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.kbackground,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorders.borderM,
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ksecondary.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.ksecondary.withOpacity(0.05),
                  borderRadius: AppBorders.borderM,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: AppBorders.borderM,
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Ink(
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'No',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.ksecondary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: AppBorders.borderM,
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Ink(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: AppColors.kprimary,
                            borderRadius: AppBorders.borderM,
                          ),
                          child: const Text(
                            'Yes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
