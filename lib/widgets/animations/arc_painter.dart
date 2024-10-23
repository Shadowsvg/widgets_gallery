import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final bool isBackground;
  final double strokeWidth;
  final Gradient? gradient;

  ArcPainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
    required this.isBackground,
    required this.strokeWidth,
    this.gradient,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height,
    );
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient?.createShader(rect);

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
