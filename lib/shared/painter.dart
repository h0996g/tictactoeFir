import 'package:flutter/material.dart';

class Pan extends StatelessWidget {
  const Pan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.yellow,
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: LinePainter(),
        ),
      )),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawLine(
      Offset(size.width * 1 / 6, size.height * 1 / 2),
      Offset(size.width * 5 / 6, size.height * 1),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
