import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/info_widget.dart';
import 'product_grid.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late Future<dynamic> fetchProducts;
  @override
  void initState() {
    fetchProducts =
        Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return FutureBuilder(
          future: fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return InfoWidget(
                  iconData: Icons.error_outline, text: "${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ProductGrid(products: provider.products);
            }
          });
    });
  }
}
