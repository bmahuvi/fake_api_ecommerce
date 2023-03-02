import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../logic/models/product.dart';
import '../../logic/view_models/products_provider.dart';
import '../widgets/image_container.dart';
import '../widgets/star_rating.dart';
import 'product_details.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 220,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return buildProductCard(product, context);
        });
  }

  Widget buildProductCard(ProductModel product, BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
        builder: (context, screenSize) => Card(
              clipBehavior: Clip.hardEdge,
              color: theme.colorScheme.primaryContainer,
              elevation: 4,
              child: InkWell(
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .setCategoryName(product.category);
                  Provider.of<ProductProvider>(context, listen: false)
                      .setProductId(product.id);
                  Get.to(() => ProductDetails(model: product));
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
                                size: screenSize.maxWidth > 480 ? 20 : 18,
                                rating: product.rating.rate,
                              ),
                            ),
                            Text(' (${product.rating.count})')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '\$ ${product.price.toStringAsFixed(2)}',
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        )
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
                              product.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
