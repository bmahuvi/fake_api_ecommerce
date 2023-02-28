import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double? size;

  const StarRating({Key? key, required this.rating, this.size = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            List.generate(5, (index) => _buildStar(index, rating, context)));
  }

  _buildStar(int index, double rating, BuildContext ctx) {
    IconData icon;
    Color color;
    if (index >= rating) {
      icon = Icons.star;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Theme.of(ctx).colorScheme.primary;
    } else {
      icon = Icons.star;
      color = Theme.of(ctx).colorScheme.primary;
    }
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
