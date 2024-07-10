import 'package:flutter/material.dart';
import 'dart:math' as math;

class FreeBodyDiagramPainter extends StatelessWidget {
  final double angle;

  const FreeBodyDiagramPainter({Key? key, required this.angle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FreeBodyDiagramPainter(
        angle: angle,
      ),
      child: Container(),
    );
  }
}

class _FreeBodyDiagramPainter extends CustomPainter {
  final double angle;

  _FreeBodyDiagramPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double radians = angle * math.pi / 180;
    double length = 500.0;
    double height = length * math.tan(radians);

    double scaleFactor = 1.0;
    if (height > size.height * 0.8 || length > size.width * 0.8) {
      scaleFactor =
          math.min(size.width * 0.8 / length, size.height * 0.8 / height);
      length *= scaleFactor;
      height *= scaleFactor;
    }

    final Offset pointA =
        Offset((size.width - length) / 2, (size.height + height) / 2);
    final Offset pointB = Offset(pointA.dx + length, pointA.dy);
    final Offset pointC = Offset(pointB.dx, pointB.dy - height);

    // Dibujar el triángulo
    canvas.drawPath(
      Path()
        ..moveTo(pointA.dx, pointA.dy)
        ..lineTo(pointB.dx, pointB.dy)
        ..lineTo(pointC.dx, pointC.dy)
        ..close(),
      paint,
    );

    final blockPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;
    final double blockSize = 20.0;

    final blockPaintSecondary = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;

    // Primer cuadrado
    final Offset blockCenter1 = Offset(
      (pointA.dx + pointC.dx) / 2,
      (pointA.dy + pointC.dy) / 2,
    );

    canvas.save();
    canvas.translate(blockCenter1.dx, blockCenter1.dy);
    canvas.rotate(-radians);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(0, 0), width: blockSize, height: blockSize),
        blockPaint);

    // Flechas del primer cuadrado
    drawArrow(canvas, Offset(0, -blockSize / 2), -math.pi / 2, 30,
        Colors.green); // Abajo
    drawArrow(canvas, Offset(-blockSize / 2, 0), math.pi, 30,
        Colors.lime); // Izquierda
    drawArrow(canvas, Offset(blockSize / 2, 0), 0, 50, Colors.pink); // Derecha

    canvas.restore();

    // Flecha vertical desde el centro del primer cubo
    drawVerticalArrow(canvas, blockCenter1, 40, Colors.blue);

    // Segundo cuadrado sin rotar
    final Offset blockCenter2 = Offset(
      (pointB.dx + pointC.dx) / 2,
      (pointB.dy + pointC.dy) / 2,
    );

    canvas.drawRect(
        Rect.fromCenter(
            center: blockCenter2, width: blockSize, height: blockSize),
        blockPaintSecondary);

    // Flechas del segundo cuadrado
    drawArrow(canvas, Offset(blockCenter2.dx, blockCenter2.dy - blockSize / 2),
        math.pi / 2, 80, Colors.blueGrey); // Arriba
    drawArrow(canvas, Offset(blockCenter2.dx, blockCenter2.dy + blockSize / 2),
        -math.pi / 2, 90, Colors.pink); // Abajo

    // Dibujar la polea
    final pulleyCenter = Offset(pointC.dx, pointC.dy);
    final pulleyRadius = 10.0;
    final pulleyPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pulleyCenter, pulleyRadius, pulleyPaint);

    // Dibujar la cuerda que conecta los dos cuerpos
    final ropePaint = Paint()
      ..color = Colors.transparent
      ..colorFilter = ColorFilter.mode(Colors.transparent, BlendMode.srcOver)
      ..strokeWidth = 1;

    final Offset ropeStart =
        blockCenter1; // Conectar al centro del primer cuadrado
    final Offset ropeEnd =
        blockCenter2; // Conectar al centro del segundo cuadrado

    canvas.drawLine(ropeStart, pulleyCenter, ropePaint);
    canvas.drawLine(pulleyCenter, ropeEnd, ropePaint);
  }

  void drawArrow(Canvas canvas, Offset center, double direction, double length,
      Color color) {
    final arrowPaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Reducir la longitud de la flecha proporcionalmente al ángulo
    final double adjustedLength = length * math.sin(angle * math.pi / 180);

    final double arrowHeadLength = 10.0;
    final Offset end = Offset(center.dx + adjustedLength * math.cos(direction),
        center.dy + adjustedLength * math.sin(direction));
    canvas.drawLine(center, end, arrowPaint);

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

  void drawVerticalArrow(
      Canvas canvas, Offset center, double length, Color color) {
    final arrowPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Reducir la longitud de la flecha proporcionalmente al ángulo
    final double adjustedLength = length * math.sin(angle * math.pi / 180);

    final double arrowHeadLength = 5.0;
    final Offset end = Offset(center.dx, center.dy + adjustedLength);
    canvas.drawLine(center, end, arrowPaint);

    // Dibujar la cabeza de la flecha
    canvas.drawLine(end,
        Offset(end.dx - arrowHeadLength, end.dy - arrowHeadLength), arrowPaint);
    canvas.drawLine(end,
        Offset(end.dx + arrowHeadLength, end.dy - arrowHeadLength), arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
