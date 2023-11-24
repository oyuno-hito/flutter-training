import 'package:flutter/material.dart';

class DegreesWidget extends StatelessWidget {
  const DegreesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            '** ℃',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '** ℃',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
