import 'package:app_store/home_screen.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // يضمن هذا السطر تهيئة خدمات Flutter المصغرة بنجاح قبل استدعاء أي دوال غير متزامنة (مثل قراءة ملفات الـ JSON المحفوظة للمفضلة)
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ShopProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, 
          foregroundColor: Colors.white, 
          elevation: 0,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
