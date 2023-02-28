import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key, required this.iconData, required this.text})
      : super(key: key);
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 40,
            child: Icon(
              iconData,
              size: 48,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
