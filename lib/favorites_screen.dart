import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("المفضلة")),
      body: provider.favorites.isEmpty
          ? Center(
              child: Text(
                "لا توجد منتجات بالمفضلة",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var item = provider.favorites[index];
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
                    // تحويل الأيقونة الثابتة إلى زر تفاعلي لإزالة المنتج من المفضلة مباشرة
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: const Color.fromARGB(255, 149, 22, 13)),
                      onPressed: () {
                        provider.toggleFavorite(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("تم الحذف من المفضلة"), backgroundColor: Colors.orange),
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
