import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';

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
              ),
            ),

            CustomPaint(
              size: const Size(300, 300),
              painter: ArcPainter(
                color: Colors.blueAccent,
                startAngle: _animation.value,
                sweepAngle: (math.pi / 2),
                isBackground: false,
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

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final bool isBackground;

  ArcPainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
    required this.isBackground,
  });
  @override
  void paint(Canvas canvas, Size size) {
    const rect = Rect.fromLTRB(0, 0, 300, 300);
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // if (isBackground) {
    //   paint.color = color; // Solid color for the background arc
    // } else {
    //   // gradient for the upper arc
    //   final gradient = LinearGradient(
    //     colors: [
    //       Colors.blueAccent.withOpacity(0), // Transparent start
    //       Colors.blueAccent, // Full color
    //       Colors.blueAccent.withOpacity(0), // Transparent end
    //     ],
    //     stops: const [0.0, 0.5, 1.0],
    //   );

    // Apply gradient shader
    // paint.shader = gradient.createShader(rect);
    // }

    // const startAngle = 0.0;
    // const sweepAngle = math.pi / 2;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint if the angles have changed

    return oldDelegate is ArcPainter &&
        (oldDelegate.startAngle != startAngle ||
            oldDelegate.sweepAngle != sweepAngle);
  }
}
