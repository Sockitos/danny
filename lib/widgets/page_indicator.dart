import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: SmoothPageIndicator(
        controller: controller,
        count: 4,
        effect: WormEffect(
          dotHeight: 12,
          dotWidth: 12,
          dotColor: Colors.white.withOpacity(0.2),
          activeDotColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
