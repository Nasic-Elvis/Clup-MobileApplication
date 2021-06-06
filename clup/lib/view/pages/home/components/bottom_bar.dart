import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xFF54D3C2)
      //..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0000750, size.height);
    path_0.lineTo(size.width * 0.0001625, size.height * 0.2537500);
    path_0.quadraticBezierTo(size.width * 0.0633375, size.height * 0.0009500,
        size.width * 0.1248250, size.height * 0.0005500);
    path_0.cubicTo(
        size.width * 0.3124094,
        size.height * 0.0004125,
        size.width * 0.6875781,
        size.height * 0.0001375,
        size.width * 0.8751625,
        0);
    path_0.quadraticBezierTo(size.width * 0.9375375, size.height * 0.0022500,
        size.width, size.height * 0.2508500);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 0.0001375, size.height);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
