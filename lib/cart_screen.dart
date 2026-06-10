import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("السلة")),
      body: provider.cart.isEmpty
          ? Center(
              child: Text(
                "السلة فارغة",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: provider.cart.length,
              itemBuilder: (context, index) {
                var item = provider.cart[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    // تحديث لعرض صور الإنترنت من الـ API
                    leading: Image.network(
                      item.image, 
                      width: 60, 
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                    ),
                    title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text("\$${item.price}"),
                    trailing: Icon(Icons.shopping_cart, color: Colors.blue),
                  ),
                );
              },
            ),
    );
  }
}
