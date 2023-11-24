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
          child: _degreeText(
            theme,
            Colors.blue,
          ),
        ),
        Expanded(
          child: _degreeText(
            theme,
            Colors.red,
          ),
        ),
      ],
    );
  }
}

Widget _degreeText(ThemeData theme, Color color) {
  return Text(
  '** ℃',
  textAlign: TextAlign.center,
  style: theme.textTheme.labelLarge?.copyWith(
      color: color,
    ),
  );
}
