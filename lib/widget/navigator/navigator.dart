import 'package:flutter/material.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _textButton('Close'),
        ),
        Expanded(
          child: _textButton('Reload'),
        ),
      ],
    );
  }
}

Widget _textButton(String value) {
  return TextButton(
    onPressed: () {}, 
    child: Text(value),
  );
}
