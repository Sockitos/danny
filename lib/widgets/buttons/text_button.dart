import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.callback,
    required this.label,
  }) : super(key: key);

  final VoidCallback callback;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        callback();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
