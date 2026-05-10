import 'package:app_store/product_details.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatelessWidget{
  final String category;

  CategoryProductsScreen({required this.category});

  @override
  Widget build(BuildContext context){
    var provider = Provider.of<ShopProvider>(context);
    var products = provider.getProductsByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7),
        itemBuilder: (context, index) {
          var product = products[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>  ProductDetailsScreen(product: product),
              ),
              );
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: Offset(0, 4)
                ),
              ]
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ClipRRect(borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)
                  ),
                  child: Image.asset(product.image, width: double.infinity, fit: BoxFit.cover),
                  ),
                  ),

                  Padding(padding: EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    
                    SizedBox(height: 5),
                    Text("\$${product.price}", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                  ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}