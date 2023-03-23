import 'package:danny/constants/borders.dart';
import 'package:danny/constants/colors.dart';
import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  const Switcher({
    Key? key,
    this.light = true,
    required this.callback,
  }) : super(key: key);

  final bool light;
  final ValueChanged<bool> callback;

  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  int _selection = 0;

  @override
  Widget build(BuildContext context) {
    const height = 48.0;
    const width = height * 5;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: AppBorders.borderL,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: _selection == 0 ? 0 : width / 2,
            child: Container(
              height: height,
              width: width / 2,
              decoration: BoxDecoration(
                color: widget.light ? Colors.white : AppColors.kprimary,
                borderRadius: AppBorders.borderL,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() => _selection = 0);
                    widget.callback(true);
                  },
                  child: Container(
                    color: _selection == 0 ? null : Colors.transparent,
                    height: height,
                    child: Center(
                      child: Text(
                        'weekly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.lerp(
                            widget.light ? AppColors.kprimary : Colors.white,
                            Colors.white.withOpacity(0.75),
                            _selection.toDouble(),
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() => _selection = 1);
                    widget.callback(false);
                  },
                  child: Container(
                    color: _selection == 1 ? null : Colors.transparent,
                    height: height,
                    child: Center(
                      child: Text(
                        'monthly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.lerp(
                            Colors.white.withOpacity(0.75),
                            widget.light ? AppColors.kprimary : Colors.white,
                            _selection.toDouble(),
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: _selection == 0 ? 0 : width / 2,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  setState(() => _selection = 1);
                  widget.callback(false);
                } else if (details.delta.dx < 0) {
                  setState(() => _selection = 0);
                  widget.callback(true);
                }
              },
              child: Container(
                height: height,
                width: width / 2,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: AppBorders.borderL,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
