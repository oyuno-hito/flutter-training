import 'package:flutter/material.dart';

class DegreesWidget extends StatelessWidget {
  const DegreesWidget({
    super.key,
    int? maxTemperature,
    int? minTemperature,
  })  : _maxTemperature = maxTemperature,
        _minTemperature = minTemperature;

  final int? _maxTemperature;
  final int? _minTemperature;

  static const _defalutValue = '**';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            '${_minTemperature ?? _defalutValue} ℃',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${_maxTemperature ?? _defalutValue} ℃',
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
