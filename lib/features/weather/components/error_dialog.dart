import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({required String errorMessage, super.key})
      : _errorMessage = errorMessage;
  final String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(_errorMessage),
      actions: [
        GestureDetector(
          child: const Text('OK'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
