import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({Key? key}) : super(key: key);

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  Future<dynamic>? fetchCategories;

  @override
  void initState() {
    fetchCategories =
        Provider.of<ProductProvider>(context, listen: false).fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer<ProductProvider>(builder: (_, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 18),
        child: FutureBuilder(
            future: fetchCategories,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const InfoWidget(
                    iconData: Icons.error_outline,
                    text: "Error while fetching categories");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 180,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: provider.categories!.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories![index];
                      return Card(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        child: Center(
                          child: Text(
                            category.toString().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    });
              }
            }),
      );
    });
  }
}
