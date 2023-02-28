import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/widgets/cart_buttons.dart';
import 'package:fake_api/ui/widgets/info_widget.dart';
import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_container.dart';

class ProductsCart extends StatelessWidget {
  const ProductsCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) => Visibility(
                visible: provider.cartItems.isNotEmpty,
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                icon: const Icon(
                                  Icons.info_outline,
                                  size: 48,
                                ),
                                title: const Text("Clear the cart"),
                                content: const Text(
                                    'All items in the cart will be cleared'),
                                actions: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 16)),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 16)),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text('No'))
                                ],
                              )).then((value) {
                        if (value) {
                        } else {}
                      });
                    },
                    child: Text(
                      'Clear cart',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ))),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
          builder: (_, provider, child) => provider.cartItems.isEmpty
              ? const SizedBox(
                  width: double.infinity,
                  child: InfoWidget(
                      iconData: Icons.remove_shopping_cart,
                      text: 'Cart is empty'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final item = provider.cartItems[index];
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Column(
                                  children: [
                                    ImageContainer(
                                        imageUrl: item.image,
                                        productId: item.id,
                                        height: 90,
                                        width: 90),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'USD ${(item.price * item.cartCount).toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ProductTitle(title: item.title),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      CartButtons(model: item),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    provider.removeProduct(item);
                                  },
                                  icon: const Icon(Icons.close)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: provider.cartItems.length)),
    );
  }
}
