import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/widgets/cart_icon_with_badge.dart';
import 'package:fake_api/ui/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_grid.dart';

class ProductsByCategory extends StatefulWidget {
  const ProductsByCategory({Key? key}) : super(key: key);

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  late Future<dynamic> fetchProductsByCategory;

  @override
  void initState() {
    fetchProductsByCategory =
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductsByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(provider.categoryName.toUpperCase()),
              actions: [IconButton(onPressed: () {}, icon: const CartIcon())],
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FutureBuilder(
                    future: fetchProductsByCategory,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return InfoWidget(
                            iconData: Icons.error_outline,
                            text: snapshot.error.toString());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ProductGrid(
                            products: provider.productsByCategory);
                      }
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
