import 'package:flutter/material.dart';

class ValueWithIndice extends StatelessWidget {
  final String value;
  final int indice;
  const ValueWithIndice({super.key, required this.value, required this.indice});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(1.0,
                  2.0), // Ajusta la posición del subíndice según sea necesario
              child: Text(
                indice.toString(),
                // Texto del subíndice
                style: TextStyle(
                  color: Colors.black.withOpacity(1),
                  fontWeight: FontWeight.bold,
                  fontSize:
                      9.5, // Ajusta el tamaño del subíndice según sea necesario
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
