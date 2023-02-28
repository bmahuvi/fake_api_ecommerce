import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../logic/view_models/products_provider.dart';
import '../routes/app_routes.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => Badge(
        alignment: const AlignmentDirectional(26, 0),
        label: Text('${provider.cartItems.length}'),
        largeSize: 18,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        isLabelVisible: provider.cartItems.isNotEmpty,
        child: child,
      ),
      child: IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.cart);
          },
          icon: const Icon(Icons.shopping_cart_outlined)),
    );
  }
}
