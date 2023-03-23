import 'package:danny/constants/borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.label,
    this.hint,
    this.keyboard = TextInputType.text,
    this.obscureText = false,
    this.capitalized = false,
    this.max = 40,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final String label;
  final String? hint;
  final TextInputType keyboard;
  final bool obscureText;
  final bool capitalized;
  final int max;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            cursorColor: Colors.white,
            keyboardType: keyboard,
            obscureText: obscureText,
            inputFormatters: [LengthLimitingTextInputFormatter(max)],
            textCapitalization: capitalized
                ? TextCapitalization.words
                : TextCapitalization.none,
            onChanged: onChanged,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderRadius: AppBorders.borderL,
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: AppBorders.borderL,
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 5, 5),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
