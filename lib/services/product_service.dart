import 'package:fake_api/logic/models/product.dart';
import 'package:fake_api/logic/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../logic/models/category.dart';

class ProductService {
  Future<List<ProductModel>> getProducts(String categoryName) async {
    List<ProductModel> products = [];
    final url = categoryName.isEmpty
        ? "${AppData.baseUrl}/products"
        : "${AppData.baseUrl}/products/category/$categoryName";
    try {
      final resp = await http
          .get(Uri.parse(Uri.encodeFull(url)))
          .timeout(AppData.httpTimeout);
      if (resp.statusCode == 200) {
        products = productsModelFromJson(resp.body);
      } else {
        throw Exception(
            ["Failed to fetch products (Code: ${resp.statusCode})"]);
      }
    } catch (e) {
      throw Exception(["Exception occurred while fetching products"]);
    }
    return products;
  }

  /*
  FETCH CATEGORIES
   */
  Future<List<String>> getCategories() async {
    List<String> categories = [];
    try {
      final resp = await http
          .get(Uri.parse(
              Uri.encodeFull("${AppData.baseUrl}/products/categories")))
          .timeout(AppData.httpTimeout);

      if (resp.statusCode == 200) {
        categories = categoryModelFromJson(resp.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
    return categories;
  }
}
