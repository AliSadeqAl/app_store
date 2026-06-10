import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'model.dart';

class ShopProvider with ChangeNotifier {
  List<Product> products = [];
  List<Product> cart = [];
  List<Product> favorites = [];

  bool isLoading = false;

  ShopProvider() {
    fetchProductsFromAPI();
    loadFavorites();
  }

  // ✅ التصنيفات
  List<String> get categories {
    return products.map((p) => p.category).toSet().toList();
  }

  // ✅ جلب المنتجات من DummyJSON
  Future<void> fetchProductsFromAPI() async {
    const String apiUrl = "https://dummyjson.com/products";

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        products = (data['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetch Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ✅ فلترة حسب التصنيف
  List<Product> getProductsByCategory(String categoryName) {
    return products.where((p) => p.category == categoryName).toList();
  }

  // ✅ السلة
  void addToCart(Product product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cart.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  // ✅ المفضلة
  void toggleFavorite(Product product) {
    final exists = favorites.any((p) => p.id == product.id);

    if (exists) {
      favorites.removeWhere((p) => p.id == product.id);
    } else {
      favorites.add(product);
    }

    notifyListeners();
    saveFavoritesLocally();
  }

  // =========================
  // 🔥 حفظ المفضلة محلياً
  // =========================

  Future<File> _getFavoritesFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/favorites.json');
  }

  Future<void> saveFavoritesLocally() async {
    final file = await _getFavoritesFile();
    final data = favorites.map((p) => p.toJson()).toList();
    await file.writeAsString(json.encode(data));
  }

  Future<void> loadFavorites() async {
    try {
      final file = await _getFavoritesFile();

      if (await file.exists()) {
        final content = await file.readAsString();

        if (content.isNotEmpty) {
          final decoded = json.decode(content);

          favorites = (decoded as List)
              .map((item) => Product.fromJson(item))
              .toList();

          notifyListeners();
        }
      }
    } catch (e) {
      print("Favorites Load Error: $e");
    }
  }
}