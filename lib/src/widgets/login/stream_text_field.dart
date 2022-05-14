import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StreamTextField extends StatelessWidget {
  final Stream stream;
  final void Function(String) onChanged;
  String hintText, labelText;
  TextInputType textInputType;
  bool obscureText;

  StreamTextField({
    required this.hintText,
    required this.labelText,
    required this.stream,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            errorText: snapshot.hasError ? snapshot.error.toString() : "",
          ),
          keyboardType: textInputType,
          obscureText: obscureText,
          onChanged: onChanged,
        );
      },
    );
  }
}
