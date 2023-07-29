import 'package:flutter/material.dart';
import 'package:super_marko/shared/styles/colors.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1737757);
    path_0.arcToPoint(Offset(size.width * 0.1438880, size.height * 0.08846761),
        radius:
            Radius.elliptical(size.width * 0.1439040, size.height * 0.08525118),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.7346667, size.height * 0.08846761);
    path_0.cubicTo(
        size.width, size.height * 0.08846761, size.width, 0, size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    // paint0Fill.color = Color(0xff07635d).withOpacity(1.0);
    paint0Fill.color = AppMainColors.mainColor;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
