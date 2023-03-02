import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/products/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Top Rated',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View all",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 120, maxHeight: 300),
          padding: const EdgeInsets.all(8),
          child: Consumer<ProductProvider>(
              builder: (_, provider, child) =>
                  ProductGrid(products: provider.topRatedProducts)),
        ),
      ],
    );
  }
}
