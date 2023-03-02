import 'package:fake_api/logic/models/product.dart';
import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/utils/constants.dart';

class CartButtons extends StatelessWidget {
  const CartButtons({Key? key, required this.model, this.iconSize = 40})
      : super(key: key);
  final ProductModel model;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, provider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: model.cartCount == 1
                        ? null
                        : () {
                            provider.changeCartCount(model, "-");
                          },
                    icon: Icon(
                      Icons.remove_circle,
                      size: iconSize,
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 80,
                  height: 40,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade500, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    '${model.cartCount}',
                    style: const TextStyle(fontSize: 20, color: Colors.black87),
                  )),
                ),
                IconButton(
                    onPressed: model.cartCount == AppData.maxCartValue
                        ? null
                        : () {
                            provider.changeCartCount(model, "+");
                          },
                    icon: Icon(
                      Icons.add_circle,
                      size: iconSize,
                    )),
              ],
            ));
  }
}
