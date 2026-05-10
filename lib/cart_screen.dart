import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var provider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("السلة")),
      body: provider.cart.isEmpty
      ? Center(
        child: Text("السلة فارغة", 
        style: TextStyle(fontSize: 20),
        ),
      )
      : ListView.builder(
        itemCount: provider.cart.length,
        itemBuilder:  (context, index){
          var item = provider.cart[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(item.image, width: 60, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text("\$${item.price}"),
              trailing: Icon(Icons.shopping_cart, color: Colors.blue),
            ),
          );
        },
        ),
    );
  }
}