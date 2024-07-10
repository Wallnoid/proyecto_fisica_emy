import 'package:flutter/material.dart';
import 'package:proyecto_fisica/components/custom_text.dart';

class Identifiers extends StatelessWidget {
  final Widget text;
  final Color color;
  const Identifiers({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        height: 10,
        width: 10,
        color: color,
      ),
      const SizedBox(width: 2.0),
      (text)
    ]);
  }
}
