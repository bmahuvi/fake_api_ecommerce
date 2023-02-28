import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {super.key,
      required this.imageUrl,
      required this.productId,
      required this.height,
      required this.width});
  final String imageUrl;
  final int productId;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 8,
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.2)),
          ],
          borderRadius: BorderRadius.circular(32)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'HERO_$productId',
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(
                Icons.hide_image_outlined,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
