import 'package:flutter/material.dart';
import 'dart:math' as math;

class TrianglePainter extends StatelessWidget {
  final double angle;

  const TrianglePainter({Key? key, required this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(
        angle: angle,
      ),
      child: Container(),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final double angle;

  _TrianglePainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double radians = angle * math.pi / 180;
    double length = 200.0; // Longitud inicial de la base del triángulo
    double height =
        length * math.tan(radians); // Altura calculada del triángulo

    // Ajustar el tamaño del triángulo para que no exceda los límites del contenedor
    double scaleFactor = 1.0;
    if (height > size.height * 0.8 || length > size.width * 0.8) {
      scaleFactor =
          math.min(size.width * 0.8 / length, size.height * 0.8 / height);
      length *= scaleFactor;
      height *= scaleFactor;
    }

    // Posición centrada del triángulo
    final Offset pointA = Offset((size.width - length) / 2, size.height - 50);
    final Offset pointB = Offset(pointA.dx + length, pointA.dy);
    final Offset pointC = Offset(pointB.dx, pointA.dy - height);

    // Dibujamos el triángulo
    canvas.drawPath(
      Path()
        ..moveTo(pointA.dx, pointA.dy)
        ..lineTo(pointB.dx, pointB.dy)
        ..lineTo(pointC.dx, pointC.dy)
        ..close(),
      paint,
    );

    // Dibujamos la polea
    final pulleyPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    final Offset pulleyCenter = pointC;
    canvas.drawCircle(pulleyCenter, 10, pulleyPaint);

    // Cuerdas y bloques
    final ropePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;
    final double dropDistance = length *
        0.25; // Distancia proporcional al tamaño ajustado del triángulo
    final Offset weight1 = Offset(
      pulleyCenter.dx - dropDistance * math.cos(radians),
      pulleyCenter.dy + dropDistance * math.sin(radians),
    );
    final Offset weight2 =
        Offset(pulleyCenter.dx, pulleyCenter.dy + dropDistance);

    canvas.drawLine(pulleyCenter, weight1, ropePaint);
    canvas.drawLine(pulleyCenter, weight2, ropePaint);

    // Dibujamos los bloques con rotación
    final blockPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    final blockSize = 20.0;

    // Guardar el estado del canvas antes de rotarlo
    canvas.save();

    // Trasladar el canvas al centro del primer bloque
    canvas.translate(weight1.dx, weight1.dy);

    // Rotar el canvas en el ángulo adecuado
    canvas.rotate(-radians);

    // Dibujar el primer bloque en el canvas rotado
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(0, 0), width: blockSize, height: blockSize),
      blockPaint,
    );

    // Restaurar el estado del canvas
    canvas.restore();

    // Guardar el estado del canvas antes de rotarlo
    canvas.save();

    // Trasladar el canvas al centro del segundo bloque
    canvas.translate(weight2.dx, weight2.dy);

    // No rotar el segundo bloque ya que debe estar vertical
    // Dibujar el segundo bloque
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(0, 0), width: blockSize, height: blockSize),
      blockPaint,
    );

    // Restaurar el estado del canvas
    canvas.restore();

    // Dibujar el texto del ángulo
    final textSpan = TextSpan(
      text: '${angle.toStringAsFixed(1)}°',
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(canvas, Offset(pointA.dx + 25, pointA.dy - 23));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
