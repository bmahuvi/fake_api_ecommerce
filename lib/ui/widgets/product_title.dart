import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle(
      {Key? key, required this.title, this.maxLines, this.overflow})
      : super(key: key);
  final String title;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      title,
      maxLines: maxLines,
      overflow: overflow,
      style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
