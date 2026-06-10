import 'package:app_store/cart_screen.dart';
import 'package:app_store/category_screen.dart';
import 'package:app_store/favorites_screen.dart';
import 'package:app_store/product_details.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("APP_STORE"),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriesScreen()));
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: Text(
                    provider.cart.length.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesScreen()));
            },
          )
        ],
      ),
      // فحص حالة التحميل الآمنة
      body: provider.isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : provider.products.isEmpty 
              ? const Center(child: Text("لا توجد منتجات حالياً. تأكد من الإنترنت"))
              : ListView(
                  children: provider.categories.map((category) {
                    // جلب المنتجات التابعة لهذا التصنيف مباشرة
                    var products = provider.getProductsByCategory(category);

                    // إذا كان التصنيف لا يحتوي على منتجات بسبب خطأ الاسم، لن نعرض عموداً فارغاً
                    if (products.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Text(
                            category.toUpperCase(), // تحويل اسم التصنيف لحروف كبيرة ليظهر بشكل منسق
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var product = products[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
                                      );
                                  },
                                  child: Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 4)),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                            child: Image.network(
                                              product.image,
                                              width: double.infinity,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.broken_image, size: 50),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "\$${product.price}",
                                                style: const TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
    );
  }
}