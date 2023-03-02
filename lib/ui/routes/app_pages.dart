import 'package:fake_api/ui/app.dart';
import 'package:fake_api/ui/products/products_by_category.dart';
import 'package:fake_api/ui/products/products_cart.dart';
import 'package:fake_api/ui/routes/app_routes.dart';
import 'package:fake_api/ui/splash/splash.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const Splash()),
    GetPage(name: AppRoutes.home, page: () => const App()),
    GetPage(name: AppRoutes.cart, page: () => const ProductsCart()),
    GetPage(
        name: AppRoutes.categoryProducts,
        page: () => const ProductsByCategory()),
  ];
}
