import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecondDiagramPainter extends StatelessWidget {
  const SecondDiagramPainter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SecondDiagramPainter(
        arrowColorUp: Colors.pink,
        arrowColorDown: Colors.blueGrey,
      ),
      child: Container(),
    );
  }
}

class _SecondDiagramPainter extends CustomPainter {
  final Color arrowColorUp;
  final Color arrowColorDown;

  _SecondDiagramPainter(
      {required this.arrowColorUp, required this.arrowColorDown});

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double length = size.height * 0.8;
    final Offset pointA = Offset(size.width / 2, (size.height - length) / 2);
    final Offset pointB = Offset(pointA.dx, pointA.dy + length);

    // Dibujar la línea vertical
    canvas.drawLine(pointA, pointB, paint);

    final blockPaint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;
    final double blockSize = 40.0;

    // Centro del cuadro rojo
    final Offset blockCenter = Offset(
      (pointA.dx + pointB.dx) / 2,
      (pointA.dy + pointB.dy) / 2,
    );

    // Dibujar el cuadro rojo en el centro de la línea
    canvas.drawRect(
        Rect.fromCenter(
            center: blockCenter, width: blockSize, height: blockSize),
        blockPaint);

    // Dibujar flechas en cada lado del rectángulo
    drawArrow(canvas, Offset(blockCenter.dx, blockCenter.dy - blockSize / 2),
        -math.pi / 2, 50, arrowColorUp); // Arriba
    drawArrow(canvas, Offset(blockCenter.dx, blockCenter.dy + blockSize / 2),
        math.pi / 2, 50, arrowColorDown); // Abajo
  }

  void drawArrow(Canvas canvas, Offset start, double direction, double length,
      Color color) {
    final arrowPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final double arrowHeadLength = 10.0;

    final Offset end = Offset(start.dx + length * math.cos(direction),
        start.dy + length * math.sin(direction));
    canvas.drawLine(start, end, arrowPaint);

    // Dibujar la cabeza de la flecha
    canvas.drawLine(
        end,
        Offset(end.dx - arrowHeadLength * math.cos(direction - math.pi / 6),
            end.dy - arrowHeadLength * math.sin(direction - math.pi / 6)),
        arrowPaint);
    canvas.drawLine(
        end,
        Offset(end.dx - arrowHeadLength * math.cos(direction + math.pi / 6),
            end.dy - arrowHeadLength * math.sin(direction + math.pi / 6)),
        arrowPaint);
  }
}
