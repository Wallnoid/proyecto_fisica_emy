import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String suffix;
  final List<TextInputFormatter>? inputFormatter;

  const CustomInput(
      {super.key,
      required this.label,
      required this.controller,
      required this.suffix,
      this.inputFormatter});

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  get label => widget.label;
  get controller => widget.controller;
  get suffix => widget.suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Ancho del TextField
      height: 40,
      // Alto del TextField
      child: TextField(
        controller: controller,
        maxLines: 1,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          LengthLimitingTextInputFormatter(10),
          ...?widget.inputFormatter,
        ],
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.8),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(suffix,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.8),
                )),
          ),
        ),
      ),
    );
  }
}
