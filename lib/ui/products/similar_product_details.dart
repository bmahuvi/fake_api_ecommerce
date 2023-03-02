import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/routes/app_routes.dart';
import 'package:fake_api/ui/widgets/cart_icon_with_badge.dart';
import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../logic/models/product.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/image_container.dart';
import '../widgets/star_rating.dart';
import 'product_details.dart';

class SimilarProductDetails extends StatelessWidget {
  const SimilarProductDetails({super.key, required this.model});
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCT DETAILS'),
        centerTitle: true,
        actions: const [
          CartIcon(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: LayoutBuilder(
          builder: (context, screenSize) => Container(
                width: size.width,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: screenSize.maxWidth > 480
                              ? size.width - 300
                              : size.width - 150,
                          height: screenSize.maxWidth > 480 ? 400 : 240,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(1, 7),
                                    blurRadius: 8,
                                    color: theme.colorScheme.shadow
                                        .withOpacity(0.2)),
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Hero(
                              tag: 'HERO_${model.id}',
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: model.image,
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.hide_image_outlined,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ProductTitle(title: model.title),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            '\$ ${model.price}',
                            style: TextStyle(
                                fontSize: screenSize.maxWidth > 480 ? 26 : 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 32,
                          right: 32,
                        ),
                        child: Consumer<ProductProvider>(
                            builder: (_, provider, child) => provider.cartItems
                                    .contains(model)
                                ? Column(
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Get.toNamed(AppRoutes.cart);
                                          },
                                          child: Center(
                                              child: Text(
                                            'View items in cart',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.maxWidth > 480
                                                        ? 18
                                                        : 16),
                                          ))),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      FilledButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(theme
                                                      .colorScheme.secondary),
                                              foregroundColor:
                                                  MaterialStatePropertyAll(theme
                                                      .colorScheme
                                                      .onSecondary)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                              child: Text(
                                            'Add more',
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.maxWidth > 480
                                                        ? 18
                                                        : 16),
                                          ))),
                                    ],
                                  )
                                : FilledButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return CustomBottomSheet(
                                              model: model,
                                            );
                                          });
                                    },
                                    child: Center(
                                        child: Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontSize: screenSize.maxWidth > 480
                                              ? 18
                                              : 16),
                                    )))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          'More information',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Text(
                              'Category',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text(model.category.toUpperCase())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Text(
                              'Rating',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  StarRating(
                                    rating: model.rating.rate,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(' (${model.rating.count})')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(child: Text(model.description)),
                          ],
                        ),
                      ),
                      Consumer<ProductProvider>(
                          builder: (_, provider, child) => Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Similar Products',
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      )),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 16),
                                    constraints: const BoxConstraints(
                                        minHeight: 120, maxHeight: 300),
                                    child: GridView.builder(
                                      itemCount:
                                          provider.similarProducts.length,
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 220,
                                              crossAxisCount: 1),
                                      itemBuilder: (context, index) {
                                        final product =
                                            provider.similarProducts[index];
                                        return Card(
                                          elevation: 4,
                                          clipBehavior: Clip.hardEdge,
                                          color: theme
                                              .colorScheme.primaryContainer,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: InkWell(
                                              onTap: () {
                                                Provider.of<ProductProvider>(
                                                        context,
                                                        listen: false)
                                                    .setCategoryName(
                                                        product.category);
                                                Provider.of<ProductProvider>(
                                                        context,
                                                        listen: false)
                                                    .setProductId(product.id);
                                                Get.off(() => ProductDetails(
                                                    model: product));
                                              },
                                              child: Column(
                                                children: [
                                                  ImageContainer(
                                                      imageUrl: product.image,
                                                      productId: product.id,
                                                      height: 100,
                                                      width: 100),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: StarRating(
                                                          size: 18,
                                                          rating: product
                                                              .rating.rate,
                                                        ),
                                                      ),
                                                      Text(
                                                          ' (${product.rating.count})')
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16.0,
                                                            right: 8),
                                                    child: ProductTitle(
                                                      title: product.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 16,
                                                      ),
                                                      child: Text(
                                                        '\$ ${product.price.toStringAsFixed(2)}',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: theme.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ))
                    ],
                  ),
                ),
              )),
    );
  }
}
