import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StreamTextField extends StatelessWidget {
  final Stream stream;
  final void Function(String) onChanged;
  String hintText, labelText;
  TextInputType textInputType;
  bool obscureText;
  int minLines, maxLines;

  StreamTextField({
    required this.hintText,
    required this.labelText,
    required this.stream,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
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
          minLines: minLines,
          maxLines: maxLines,
        );
      },
    );
  }
}
