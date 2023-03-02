import 'package:fake_api/ui/products/product_grid.dart';
import 'package:fake_api/ui/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/models/product.dart';
import '../../logic/view_models/products_provider.dart';

class SearchProducts extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search by title';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> suggestions = provider.products
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions.isEmpty
        ? const Center(
            child: InfoWidget(iconData: Icons.info_outline, text: "No matches"))
        : ProductGrid(products: suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> suggestions = provider.products
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ProductGrid(products: suggestions);
  }
}
