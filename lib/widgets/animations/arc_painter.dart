import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double strokeWidth;
  final Gradient? gradient;

  ArcPainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
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
