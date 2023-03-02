import 'dart:collection';

import 'package:fake_api/services/product_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _productsByCategory = [];
  List<ProductModel> _products = [];
  List<String> _categories = [];
  int _productId = -1;
  double _sum = 0;

  // Getters
  get categories => _categories;
  get categoryName => _categoryName;
  get productId => _productId;
  double get sum => _sum;

  final ProductService service = ProductService();

  //fetch products per category
  String _categoryName = "";

  void setCategoryName(String categoryName) => _categoryName = categoryName;
  void setProductId(int productId) => _productId = productId;

  UnmodifiableListView<ProductModel> get productsByCategory => _categoryName
          .isEmpty
      ? UnmodifiableListView(_productsByCategory)
      : UnmodifiableListView(_productsByCategory
          .where((element) => element.category.toLowerCase() == _categoryName));

  UnmodifiableListView<ProductModel> get products =>
      UnmodifiableListView(_products);

  UnmodifiableListView<ProductModel> get topRatedProducts =>
      UnmodifiableListView(
          _products.where((element) => element.rating.rate >= 4.5));

  UnmodifiableListView<ProductModel> get similarProducts {
    return UnmodifiableListView(_products.where((element) =>
        element.category == _categoryName && element.id != _productId));
  }

  fetchProductsByCategory() async {
    try {
      _productsByCategory = await service.getProducts(_categoryName);
      notifyListeners();
    } catch (e) {
      throw Exception([e.toString()]);
    }
  }

  //add products to cart
  void addProductToCart(int id) {
    final index = _products.indexWhere((element) => element.id == id);
    _products[index].changeCartStatus();
    _sum += _products[index].price * _products[index].cartCount;
    notifyListeners();
  }

  //remove product from cart
  void removeProduct(int id) {
    final index = _products.indexWhere((element) => element.id == id);
    _products[index].changeCartStatus();
    _sum -= _products[index].price * _products[index].cartCount;
    notifyListeners();
  }

  //get cart items
  UnmodifiableListView<ProductModel> get cartItems {
    return UnmodifiableListView(
        _products.where((element) => element.inCart == true));
  }

  //increment/decrement cart count
  void changeCartCount(ProductModel product, String action) {
    final index = _products.indexOf(product);
    _products[index].changeCount(action);
    if (action == "-") {
      _sum -= _products[index].price;
    } else {
      _sum += _products[index].price;
    }
    notifyListeners();
  }

  //Sort products by price low to high
  void sortPriceFromLow() {
    _products.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  //Sort products by price high to low
  void sortPriceFromHigh() {
    _products.sort((b, a) => a.price.compareTo(b.price));
    notifyListeners();
  }

  //Sort products by rating low to high
  void sortRatingFromLow() {
    _products.sort((a, b) => a.rating.rate.compareTo(b.rating.rate));
    notifyListeners();
  }

  //Sort products by rating high to low
  void sortRatingFromHigh() {
    _products.sort((b, a) => a.rating.rate.compareTo(b.rating.rate));
    notifyListeners();
  }

  /*
  Fetch categories from API
   */
  fetchCategories() async {
    try {
      if (_categories.isEmpty) {
        _categories = await service.getCategories();
        notifyListeners();
      }
    } catch (e) {
      throw Exception();
    }
  }

  /*
  Fetch products
   */
  fetchProducts() async {
    try {
      if (_products.isEmpty) {
        _products = await service.getProducts("");
        notifyListeners();
      }
    } catch (e) {
      throw Exception([e.toString()]);
    }
  }
}
