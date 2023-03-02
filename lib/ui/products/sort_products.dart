import 'package:fake_api/logic/view_models/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortProducts extends StatefulWidget {
  const SortProducts({super.key});

  @override
  State<SortProducts> createState() => _SortProductsState();
}

class _SortProductsState extends State<SortProducts>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(
          Icons.filter_list,
          size: 32,
        ),
        title: const Text('Order By:'),
        content: Consumer<ProductProvider>(builder: (_, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Price",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  provider.sortPriceFromLow();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.attach_money_outlined),
                horizontalTitleGap: 0,
                title: const Text('Low to High'),
                trailing: const Icon(Icons.arrow_upward),
              ),
              ListTile(
                onTap: () {
                  provider.sortPriceFromHigh();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.attach_money_outlined),
                horizontalTitleGap: 0,
                title: const Text('High to Low'),
                trailing: const Icon(Icons.arrow_downward),
              ),
              Text(
                "Rating",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  provider.sortRatingFromLow();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.star_rate_outlined),
                horizontalTitleGap: 0,
                title: const Text('Low to High'),
                trailing: const Icon(Icons.arrow_upward),
              ),
              ListTile(
                onTap: () {
                  provider.sortRatingFromHigh();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.star_rate_outlined),
                horizontalTitleGap: 0,
                title: const Text('High to Low'),
                trailing: const Icon(Icons.arrow_upward),
              ),
              const Divider(),
              Center(
                  child: FilledButton(
                      onPressed: () {}, child: const Text("Reset")))
            ],
          );
        }),
      ),
    );
  }
}
