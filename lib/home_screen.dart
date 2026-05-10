import 'package:app_store/cart_screen.dart';
import 'package:app_store/category_screen.dart';
import 'package:app_store/favorites_screen.dart';
import 'package:app_store/product_details.dart';
import 'package:app_store/provider.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     var provider = Provider.of<ShopProvider>(context);

     return Scaffold(appBar: AppBar(title: Text("APP_STOR"),

     actions: [
      IconButton( icon: Icon(Icons.category),
      onPressed: (){Navigator.push(context,  MaterialPageRoute(builder: (_) => CategoriesScreen()),
      );
      },
      ),

      Stack(
        children: [
          IconButton(icon:  Icon(Icons.shopping_cart),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_) =>  CartScreen()));
          },
          ),
          Positioned(
            right: 5,
            top: 5,
            child: CircleAvatar(radius: 10, backgroundColor: Colors.blue,
            child: Text(provider.cart.length.toString(),
            style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 196, 186, 186)),
            ),
            ),
            ),
        ],
      ),

      IconButton(icon: Icon(Icons.favorite),
      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_) =>  FavoritesScreen()));
      } 
      )
     ],
     ),

     body: ListView(
      children: provider.categories.map((Category) {
        var products =provider.getProductsByCategory(Category);

        return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(Category, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),),
          ),

          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index){
                var product=products[index];

                return Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                 child:  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>  ProductDetailsScreen(product: product)),
                    );
                  },
                  child: Container(
                    width: 170,  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: Offset(0, 4)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.asset(product.image, width: double.infinity, fit: BoxFit.cover),
                        ),
                      ),

                      Padding(padding: EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 5),
                        Text("\$${product.price}",
                        style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
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