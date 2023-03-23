library avatar_glow;

import 'dart:async';

import 'package:flutter/material.dart';

class AvatarGlow extends StatefulWidget {
  const AvatarGlow({
    Key? key,
    required this.child,
    required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.animate = true,
    this.repeatPauseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.fastOutSlowIn,
    this.showTwoGlows = true,
    this.glowColor = Colors.white,
    this.startDelay,
  }) : super(key: key);

  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool animate;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration? startDelay;

  @override
  _AvatarGlowState createState() => _AvatarGlowState();
}

class _AvatarGlowState extends State<AvatarGlow>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final _curve = CurvedAnimation(
    parent: controller,
    curve: widget.curve,
  );
  late final smallDiscAnimation = Tween<double>(
    begin: widget.endRadius,
    end: widget.endRadius * 2,
  ).animate(_curve);

  late final bigDiscAnimation = Tween<double>(
    begin: 0,
    end: (widget.endRadius * 2) * 0.9,
  ).animate(_curve);
  late final alphaAnimation =
      Tween<double>(begin: 0.30, end: 0).animate(controller);

  Future<void> _statusListener(AnimationStatus _) async {
    if (controller.status == AnimationStatus.completed) {
      await Future<void>.delayed(widget.repeatPauseDuration);

      if (mounted && widget.repeat && widget.animate) {
        controller.reset();
        await controller.forward();
      }
    }
  }

  @override
  void initState() {
    if (widget.animate) {
      _startAnimation();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(AvatarGlow oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _startAnimation() async {
    controller.addStatusListener(_statusListener);
    if (widget.startDelay != null) {
      await Future<void>.delayed(widget.startDelay!);
    }
    if (mounted) {
      controller.reset();
      await controller.forward();
    }
  }

  Future<void> _stopAnimation() async {
    controller.removeStatusListener(_statusListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.endRadius * 2,
      width: widget.endRadius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: bigDiscAnimation,
            builder: (context, child) {
              // If the user picks a curve that goes below 0,
              // this will throw without clamping
              final size = bigDiscAnimation.value.clamp(0.0, double.infinity);

              return Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: widget.shape,
                  // If the user picks a curve that goes below 0 or above 1
                  // this opacity will have unexpected effects without clamping
                  color: widget.glowColor
                      .withOpacity(alphaAnimation.value.clamp(0.0, 1.0)),
                ),
              );
            },
          ),
          if (widget.showTwoGlows)
            AnimatedBuilder(
              animation: smallDiscAnimation,
              builder: (context, child) {
                final size =
                    smallDiscAnimation.value.clamp(0.0, double.infinity);

                return Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    shape: widget.shape,
                    // If the user picks a curve that goes below 0 or above 1
                    // this opacity will have unexpected effects without clamping
                    color: widget.glowColor
                        .withOpacity(alphaAnimation.value.clamp(0.0, 1.0)),
                  ),
                );
              },
            ),
          widget.child,
        ],
      ),
    );
  }
}
