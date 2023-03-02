import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:fake_api/ui/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/search.dart';
import '../products/sort_products.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Consumer(builder: (context, provider, child) {
            return SliverAppBar.large(
              floating: false,
              pinned: true,
              snap: false,
              backgroundColor: colorScheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: const Opacity(
                  opacity: 0.4,
                  child: Image(
                    image: AssetImage(
                      "assets/images/bg.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/cart.png",
                      height: 32,
                      color: colorScheme.onPrimary,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'FakeAPI',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              actions: [
                Consumer<ProductProvider>(
                  builder: (_, provider, child) => IconButton(
                      onPressed: provider.products.isEmpty
                          ? null
                          : () {
                              showSearch(
                                  context: context, delegate: SearchProducts());
                            },
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: colorScheme.onPrimary,
                      )),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const SortProducts());
                    },
                    icon: Icon(
                      Icons.filter_list,
                      size: 30,
                      color: colorScheme.onPrimary,
                    ))
              ],
            );
          }),
          SliverList(
              delegate: SliverChildListDelegate([
            const ProductsView(),
          ]))
        ],
      ),
    );
  }
}
