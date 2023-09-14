import 'dart:ui';

import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(size.width / 4.5, size.height / 1.09)
      ..lineTo(size.width / 4.5, size.height / 1.28)
      ..arcToPoint(Offset(size.width / 3.2, size.height / 1.33),
          radius: const Radius.circular(50), clockwise: true)
      ..lineTo(size.width / 1.3, size.height / 1.33)
      ..lineTo(size.width / 1.3, size.height / 1.62)
      ..arcToPoint(Offset(size.width / 1.5, size.height / 1.72),
          radius: const Radius.circular(50), clockwise: false)
      ..lineTo(size.width / 4.5, size.height / 1.72)
      ..lineTo(size.width / 4.5, size.height / 2.2)
      ..arcToPoint(Offset(size.width / 3, size.height / 2.4),
          radius: const Radius.circular(50), clockwise: true)
      ..lineTo(size.width / 1.3, size.height / 2.4)
      ..lineTo(size.width / 1.3, size.height / 3.5)
      ..arcToPoint(Offset(size.width / 1.45, size.height / 4),
          radius: const Radius.circular(50), clockwise: false)
      ..lineTo(size.width / 4.5, size.height / 4)
      ..lineTo(size.width / 4.5, size.height / 8.5)
      ..arcToPoint(Offset(size.width / 3.2, size.height / 11),
          radius: const Radius.circular(50), clockwise: true)
      ..lineTo(size.width / 1.3, size.height / 11);

    Path dashPath = Path();

    double dashWidth = 10.0;
    double dashSpace = 5.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) => true;
}
