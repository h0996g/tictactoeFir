import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final String winningLine;
  WinningLinePainter(this.winningLine);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF2C5364)
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    double thirdWidth = size.width / 3;
    double thirdHeight = size.height / 3;
    double padding =
        size.width * 0.1; // Adjust this value to change the line length

    switch (winningLine) {
      case 'row0':
        canvas.drawLine(
          Offset(padding, thirdHeight / 2),
          Offset(size.width - padding, thirdHeight / 2),
          paint,
        );
        break;
      case 'row1':
        canvas.drawLine(
          Offset(padding, thirdHeight * 1.5),
          Offset(size.width - padding, thirdHeight * 1.5),
          paint,
        );
        break;
      case 'row2':
        canvas.drawLine(
          Offset(padding, thirdHeight * 2.5),
          Offset(size.width - padding, thirdHeight * 2.5),
          paint,
        );
        break;
      case 'col0':
        canvas.drawLine(
          Offset(thirdWidth / 2, padding),
          Offset(thirdWidth / 2, size.height - padding),
          paint,
        );
        break;
      case 'col1':
        canvas.drawLine(
          Offset(thirdWidth * 1.5, padding),
          Offset(thirdWidth * 1.5, size.height - padding),
          paint,
        );
        break;
      case 'col2':
        canvas.drawLine(
          Offset(thirdWidth * 2.5, padding),
          Offset(thirdWidth * 2.5, size.height - padding),
          paint,
        );
        break;
      case 'diag0':
        canvas.drawLine(
          Offset(padding, padding),
          Offset(size.width - padding, size.height - padding),
          paint,
        );
        break;
      case 'diag1':
        canvas.drawLine(
          Offset(size.width - padding, padding),
          Offset(padding, size.height - padding),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
