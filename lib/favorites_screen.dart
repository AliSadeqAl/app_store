 import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 class FavoritesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     var provider = Provider.of<ShopProvider>(context);

     return Scaffold(
      appBar: AppBar(title: Text("المفضلة")),
      body: provider.favorites.isEmpty
      ? Center(
        child: Text("لا توجد منتجات بالمفضلة",
        style: TextStyle(fontSize: 20),
        ),
      )
      : ListView.builder(
        itemCount: provider.favorites.length,
        itemBuilder:  (context, index){
          var item = provider.favorites[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(item.image, width: 60, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text("\$${item.price}"),
              trailing: Icon(Icons.favorite, color: const Color.fromARGB(255, 149, 22, 13)),
              ),
          );
        },
        ),
     );
  }
 }