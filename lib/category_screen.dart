import 'package:app_store/category_products.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("الفئات")),
      body: provider.categories.isEmpty
          ? const Center(child: Text("لا توجد فئات متاحة حالياً", style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                String category = provider.categories[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.category, color: Colors.blue),
                    title: Text(
                      category.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CategoryProductsScreen(category: category)),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
