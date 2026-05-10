import 'package:app_store/model.dart';
import 'package:flutter/material.dart';

class ShopProvider with ChangeNotifier{
  List<Product> products =[
    Product(id: 1, name: "Laptop", image: "image/Screenshot_٢٠٢٦٠٥٠١-٢١٠٨١٧_Google.jpg", price: 700, description: "Powerful Laptops", category: "Electronics"),
    Product(id: 2, name: "Telephone", image: "image/180097.jpg", price: 200, description: "Good Telephones", category: "Electronics"),
    Product(id: 3, name: "Headphone", image: "image/180098.jpg", price: 80, description: "Powerful Headphone", category: "Electronics"),
    Product(id: 4, name: "Watches", image: "image/180099.jpg", price: 100, description: "Good Watches", category: "Electronics"),
    Product(id: 5, name: "Football", image: "image/180100.jpg", price: 20, description: "Good ", category: "Sports"),
    Product(id: 6, name: "Baskcetball", image: "image/180102.jpg", price: 30, description: "Good ", category: "Sports"),
    Product(id: 7, name: "Tennis", image: "image/180101.jpg", price: 25, description: "Good ", category: "Sports"),
    Product(id: 8, name: "Golf", image: "image/180103.jpg", price: 15, description: "Good ", category: "Sports"),
    Product(id: 9, name: "Guitar", image: "image/180108.jpg", price: 1000, description: "Good ", category: "Music"),
    Product(id: 10, name: "Piano", image: "image/180109.jpg", price: 1500, description: "Good ", category: "Music"),
    Product(id: 11, name: "Violin ", image: "image/180111.jpg", price: 1200, description: "Good ", category: "Music"),
    Product(id: 12, name: "Micrafon ", image: "image/180110.jpg", price: 900, description: "Good ", category: "Music"),
    Product(id: 13, name: "Jacket ", image: "image/180106.jpg", price: 400, description: "Good Jacket", category: "Clothes"),
    Product(id: 14, name: " Bag", image: "image/180104.jpg", price: 300, description: "Good Bag ", category: "Clothes"),
    Product(id: 15, name: "Shoes ", image: "image/180105.jpg", price: 200, description: "Good Shoes", category: "Clothes"),
    Product(id: 16, name: "Hat ", image: "image/180107.jpg", price: 50, description: "Good Hat", category: "Clothes"),
  ];

  List<String> categories =["Electronics", "Sports", "Music", "Clothes"];
  List<Product> cart =[];
  List<Product> favorites =[];

  void addToCart(Product product){
    cart.add(product);
    notifyListeners();
  }

  void addToFavorites(Product product){
    favorites.add(product);
    notifyListeners();
  }

  List<Product> getProductsByCategory(String category){
    return products.where((p) => p.category == category).toList();
  }
}