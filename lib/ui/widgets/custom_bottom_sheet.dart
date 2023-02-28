import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/widgets/cart_buttons.dart';
import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/models/product.dart';
import 'image_container.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key, required this.model}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (_, provider, child) => Container(
              constraints: BoxConstraints(
                minHeight: 150,
                maxHeight: MediaQuery.of(context).size.height / 2,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    child: Container(
                      height: 6,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ImageContainer(
                          imageUrl: model.image,
                          productId: model.id,
                          height: 80,
                          width: 80),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitle(
                            title: model.title,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'USD ${model.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CartButtons(model: model),
                  const Divider(
                    indent: 64,
                    endIndent: 64,
                  ),
                  Align(
                    child: Text(
                      'TOTAL \$ ${(model.price * model.cartCount).toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Divider(
                    indent: 64,
                    endIndent: 64,
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    width: 180,
                    child: FilledButton.icon(
                        onPressed: () {
                          provider.addProductToCart(model.id);
                          if (provider.productsByCategory.indexWhere(
                                  (element) => element.id == model.id) !=
                              -1) {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        label: Text(
                          'Add ${model.cartCount} ${model.cartCount == 1 ? ' item' : ' items'}',
                          style: const TextStyle(fontSize: 16),
                        )),
                  )
                ],
              ),
            ));
  }
}
