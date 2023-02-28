import 'package:fake_api/ui/products/product_categories.dart';
import 'package:fake_api/ui/products/products_view.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cart.png",
                  height: 32,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  'FakeAPI',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            bottom: const TabBar(
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    icon: Icon(Icons.list_alt),
                    text: 'Products',
                  ),
                  Tab(
                    icon: Icon(Icons.dashboard),
                    text: 'Categories',
                  ),
                ]),
          ),
          body: TabBarView(children: [ProductsView(), ProductCategories()])),
    );
  }
}
