import 'package:app_store/home_screen.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ShopProvider(),
      child:  MyApp(),
    ),
  );
}

  class MyApp extends StatelessWidget{
    const MyApp({super.key});
    
    @override
    Widget build(BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xffF5F7FA),

          appBarTheme: AppBarTheme(backgroundColor: Colors.blue, foregroundColor: const Color.fromARGB(255, 255, 255, 255), elevation: 0,),
        ),
        home: HomeScreen(),
      );
    }
  }

