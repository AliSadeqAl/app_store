import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("المفضلة")),
      body: provider.favorites.isEmpty
          ? const Center(child: Text("لا توجد منتجات بالمفضلة", style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var item = provider.favorites[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      item.image, 
                      width: 60, 
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                    ),
                    title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text("\$${item.price}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Color.fromARGB(255, 149, 22, 13)),
                      onPressed: () {
                        provider.toggleFavorite(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم الحذف من المفضلة"), backgroundColor: Colors.orange),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
