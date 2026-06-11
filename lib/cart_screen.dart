import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("السلة")),
      body: provider.cart.isEmpty
          ? const Center(child: Text("السلة فارغة", style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: provider.cart.length,
              itemBuilder: (context, index) {
                var item = provider.cart[index];
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
                    trailing: const Icon(Icons.shopping_cart, color: Colors.blue),
                  ),
                );
              },
            ),
    );
  }
}
