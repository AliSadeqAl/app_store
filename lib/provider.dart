import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_store/model.dart';

class ShopProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Product> cart = [];
  List<Product> favorites = [];
  
  // قائمة الفئات المشتقة تلقائياً من الفايربيس لشاشة الفئات
  List<String> categories = [];

  ShopProvider() {
    loadFavorites();
    seedProductsIfEmpty(); // رفع بيانات وهمية تلقائياً للفايربيس إذا كان فارغاً تماماً
  }

  // ================= قسم الـ Authentication =================

  // إنشاء حساب جديد
  Future<String?> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message; // إرجاع رسالة الخطأ
    }
  }

  // تسجيل الدخول
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ================= قسم الـ Firestore والـ Streams =================

  // جلب المنتجات بث حي مباشر ومستمر snapshots()
  Stream<List<Product>> getStreamProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      List<Product> fetchedProducts = snapshot.docs.map((doc) {
        return Product.fromDoc(doc.data(), doc.id);
      }).toList();
      
      // تحديث قائمة الفئات ديناميكياً بناءً على المنتجات المتوفرة بالسيرفر
      var dynamicCategories = fetchedProducts.map((p) => p.category).toSet().toList();
      if (categories.length != dynamicCategories.length) {
        categories = dynamicCategories;
        // تأخير التنبيه قليلاً لتجنب تعارض الـ Build المستمر في فلاتر
        Future.delayed(Duration.zero, () => notifyListeners());
      }
      
      return fetchedProducts;
    });
  }

  // نقل البيانات الوهمية القديمة وتخزينها بالفايربيس تلقائياً لمرة واحدة فقط لتسهيل الفحص والتجربة
  Future<void> seedProductsIfEmpty() async {
    var snapshot = await _db.collection('products').limit(1).get();
    if (snapshot.docs.isEmpty) {
      List<Map<String, dynamic>> mockData = [
        {"name": "Laptop", "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8", "price": 700.0, "description": "Powerful Laptop", "category": "Electronics"},
        {"name": "Telephone", "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9", "price": 200.0, "description": "Good Telephone", "category": "Electronics"},
        {"name": "Headphone", "image": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e", "price": 80.0, "description": "Powerful Headphone", "category": "Electronics"},
        {"name": "Football", "image": "https://images.unsplash.com/photo-1508098682722-e99c43a406b2", "price": 20.0, "description": "Good Ball", "category": "Sports"},
        {"name": "Guitar", "image": "https://images.unsplash.com/photo-1510915361894-db8b60106cb1", "price": 1000.0, "description": "Acoustic Guitar", "category": "Music"},
        {"name": "Jacket", "image": "https://images.unsplash.com/photo-1551028719-00167b16eac5", "price": 400.0, "description": "Leather Jacket", "category": "Clothes"}
      ];

      for (var item in mockData) {
        await _db.collection('products').add(item);
      }
    }
  }

  // ================= إدارة السلة والمفضلة (المحلية JSON) =================
  void addToCart(Product product) {
    cart.add(product);
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    final isExist = favorites.any((p) => p.id == product.id);
    if (isExist) {
      favorites.removeWhere((p) => p.id == product.id);
    } else {
      favorites.add(product);
    }
    notifyListeners();
    saveFavoritesLocally();
  }

  Future<File> _getFavoritesFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/favorites.json');
  }

  Future<void> saveFavoritesLocally() async {
    final file = await _getFavoritesFile();
    List<Map<String, dynamic>> mapped = favorites.map((p) => p.toJson()).toList();
    await file.writeAsString(json.encode(mapped));
  }

  Future<void> loadFavorites() async {
    try {
      final file = await _getFavoritesFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        List<dynamic> decoded = json.decode(content);
        favorites = decoded.map((item) => Product.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("خطأ في تحميل المفضلة المحلية: $e");
    }
  }
}
