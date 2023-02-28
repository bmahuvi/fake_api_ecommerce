import 'package:fake_api/ui/routes/app_routes.dart';
import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/models/product.dart';
import '../widgets/image_container.dart';
import '../widgets/star_rating.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 220,
        ),
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return buildProductCard(product, context);
        });
  }

  Widget buildProductCard(ProductModel product, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageContainer(
                    imageUrl: product.image,
                    productId: product.id,
                    height: 100,
                    width: 100),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: StarRating(
                        rating: product.rating.rate,
                      ),
                    ),
                    Text(' (${product.rating.count})')
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 8),
                    child: ProductTitle(
                      title: product.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'USD ${product.price}',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
