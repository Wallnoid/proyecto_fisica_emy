import 'package:flutter/material.dart';

class LineText extends StatelessWidget {
  final String text;
  final int strikeThroughIndex;
  final double fontSize;

  LineText({
    required this.text,
    required this.strikeThroughIndex,
    this.fontSize = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomPaint(
          painter: _DiagonalStrikethroughPainter(
            text: text,
            strikeThroughIndex: strikeThroughIndex,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}

class _DiagonalStrikethroughPainter extends CustomPainter {
  final String text;
  final int strikeThroughIndex;
  final double fontSize;

  _DiagonalStrikethroughPainter({
    required this.text,
    required this.strikeThroughIndex,
    required this.fontSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final charOffset = textPainter.getOffsetForCaret(
      TextPosition(offset: strikeThroughIndex),
      Rect.zero,
    );

    final charSize = textPainter.size.width / text.length;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.0;

    // Desplazamiento vertical para mover la línea un poco más abajo
    final verticalOffset = fontSize * 0.3;

    final startOffset = Offset(charOffset.dx, charOffset.dy + verticalOffset);
    final endOffset = Offset(
      charOffset.dx + charSize,
      charOffset.dy + fontSize + verticalOffset,
    );

    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
