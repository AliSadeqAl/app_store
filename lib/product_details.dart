import 'package:app_store/model.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget{
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context){
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20),
          child: Image.asset(product.image, height: 300, width: double.infinity, fit: BoxFit.cover),
          ),

          SizedBox(height: 20),
          Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),
          Text("\$${product.price}", style: TextStyle(fontSize: 22, color: Colors.blue, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),
          Text(product.description, style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),

          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: (){
              provider.addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("تمت اضافة المنتج للسلة"), backgroundColor: Colors.green),
              );
            },
            icon: Icon(Icons.shopping_cart),
             label:  Text("اضافة للسلة"), 
             style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, 
             minimumSize: Size(double.infinity, 50),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)
             ),
             ),
             ),

             SizedBox(height: 15),
             ElevatedButton.icon(
              onPressed: (){
                provider.addToFavorites(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تمت الاضافة للمفضلة"), backgroundColor: const Color.fromARGB(255, 146, 21, 12)),
                );
              }, 
              icon: Icon(Icons.favorite),
              label: Text("اضافة للمفضلة"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 146, 21, 13),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
              ),
              ),
        ),
        ],
        ),
      ),
      );   
  }}
      