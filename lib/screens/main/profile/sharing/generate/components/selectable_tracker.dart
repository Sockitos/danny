import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectableTracker extends StatelessWidget {
  const SelectableTracker({
    Key? key,
    required this.tracker,
    required this.selected,
    required this.callback,
  }) : super(key: key);

  final String tracker;
  final bool selected;
  final ValueChanged<String> callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(4, 8),
            color: AppColors.ksecondary.withOpacity(0.1),
          ),
        ],
        border: Border.all(color: AppColors.kprimary, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Center(
                child: Text(
                  tracker,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kprimary,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Feedback.forTap(context);
              callback(tracker);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: selected ? AppColors.kprimary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.kprimary, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
