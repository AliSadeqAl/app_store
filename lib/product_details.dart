import 'package:app_store/model.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    bool isFav = provider.favorites.any((p) => p.id == product.id);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.image, 
                height: 300, 
                width: double.infinity, 
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product.price}", style: const TextStyle(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text(product.description, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              onPressed: () {
                provider.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تمت إضافة المنتج للسلة"), backgroundColor: Colors.green),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("إضافة للسلة"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            
            ElevatedButton.icon(
              onPressed: () {
                provider.toggleFavorite(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFav ? "تم الحذف من المفضلة" : "تمت الإضافة للمفضلة"), 
                    backgroundColor: isFav ? Colors.orange : Colors.redAccent
                  ),
                );
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              label: Text(isFav ? "إزالة من المفضلة" : "إضافة للمفضلة"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFav ? Colors.grey[600] : const Color.fromARGB(255, 146, 21, 13),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
