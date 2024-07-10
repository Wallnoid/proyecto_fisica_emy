import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool? title;
  const CustomText({
    super.key,
    required this.text,
    this.title = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: !title! ? FontWeight.bold : FontWeight.w800,
            fontSize: 15));
  }
}
