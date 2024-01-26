import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({required String errorMessage, super.key})
      : _errorMessage = errorMessage;
  final String _errorMessage;

  @visibleForTesting
  static final okButtonKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(_errorMessage),
      actions: [
        TextButton(
          key: okButtonKey,
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
