import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/widgets/cart_buttons.dart';
import 'package:fake_api/ui/widgets/info_widget.dart';
import 'package:fake_api/ui/widgets/product_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_container.dart';

class ProductsCart extends StatefulWidget {
  const ProductsCart({super.key});

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
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
                                    provider.removeProduct(item.id);
                                    if (!provider.cartItems.contains(item)) {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Product removed from the cart",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
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
      bottomNavigationBar: Consumer<ProductProvider>(
        builder: (_, provider, child) {
          return BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    const Text("Grand Total"),
                    Text(" ${provider.sum.toStringAsFixed(2)}"),
                  ],
                )),
                Expanded(
                    child: FilledButton(
                        onPressed: () {}, child: const Text("Checkout")))
              ],
            ),
          );
        },
      ),
    );
  }
}
