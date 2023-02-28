import 'dart:collection';

import 'package:fake_api/services/product_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  int _productIndex = -1;
  List<ProductModel> _productsByCategory = [];
  List<ProductModel> _products = [];
  List<String> _categories = [];

  // Categories getter
  get categories => _categories;
  get categoryName => _categoryName;

  final ProductService service = ProductService();

  //fetch products per category
  String _categoryName = "";

  void setCategoryName(String categoryName) => _categoryName = categoryName;

  UnmodifiableListView<ProductModel> get productsByCategory => _categoryName
          .isEmpty
      ? UnmodifiableListView(_productsByCategory)
      : UnmodifiableListView(_productsByCategory
          .where((element) => element.category.toLowerCase() == _categoryName));

  UnmodifiableListView<ProductModel> get products =>
      UnmodifiableListView(_products);

  fetchProductsByCategory() async {
    try {
      _productsByCategory = await service.getProducts(_categoryName);
      notifyListeners();
    } catch (e) {
      throw Exception([e.toString()]);
    }
  }

  getProductIndex(int id) {
    _productIndex =
        _productsByCategory.indexWhere((element) => element.id == id);
  }

  int get productIndex => _productIndex;

  //add products to cart
  void addProductToCart(int id) {
    getProductIndex(id);
    _productsByCategory[productIndex].changeCartStatus();
    notifyListeners();
  }

  //remove product from cart
  void removeProduct(ProductModel product) {
    _productsByCategory.remove(product);
    notifyListeners();
  }

  //get cart items
  UnmodifiableListView<ProductModel> get cartItems => UnmodifiableListView(
      _productsByCategory.where((element) => element.inCart == true));

  //increment/decrement cart count
  void changeCartCount(int id, String action) {
    getProductIndex(id);
    _productsByCategory[productIndex].changeCount(action);
    notifyListeners();
  }

  //Sort products by price low to high
  void sortPriceFromLow() {
    _productsByCategory.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  //Sort products by price high to low
  void sortPriceFromHigh() {
    _productsByCategory.sort((b, a) => a.price.compareTo(b.price));
    notifyListeners();
  }

  //Sort products by rating low to high
  void sortRatingFromLow() {
    _productsByCategory.sort((a, b) => a.rating.rate.compareTo(b.rating.rate));
    notifyListeners();
  }

  //Sort products by rating high to low
  void sortRatingFromHigh() {
    _productsByCategory.sort((b, a) => a.rating.rate.compareTo(b.rating.rate));
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
