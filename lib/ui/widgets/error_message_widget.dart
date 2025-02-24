import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorMessageWidget(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }
}
