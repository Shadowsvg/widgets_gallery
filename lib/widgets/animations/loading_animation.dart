import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';
import 'package:widgets_gallery/widgets/animations/arc_painter.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(300, 300),
              painter: ArcPainter(
                color: Colors.blueAccent.shade100.withOpacity(0.3),
                startAngle: 0,
                sweepAngle: math.pi * 2,
                isBackground: true,
                strokeWidth: 10,
              ),
            ),

            CustomPaint(
              size: const Size(300, 300),
              painter: ArcPainter(
                color: Colors.blueAccent,
                startAngle: _animation.value,
                sweepAngle: (math.pi / 2),
                isBackground: false,
                strokeWidth: 10,
              ),
            ),
            // CustomPaint(
            //   size: const Size(300, 300),
            //   painter: ArcPainter(),
            // ),
          ],
        ),
      ),
    );
  }
}

