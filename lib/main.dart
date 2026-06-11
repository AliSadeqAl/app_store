import 'package:app_store/home_screen.dart';
import 'package:app_store/login.dart';
import 'package:app_store/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تهيئة الفايربيس قبل بناء التطبيق
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
      // استخدام الـ StreamBuilder لتوجيه المستخدم تلقائياً حسب حالة حسابه
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return HomeScreen(); // إذا كان مسجلاً للدخول يفتح الواجهة الرئيسية مباشرة
          }
          return LoginScreen(); // إذا لم يكن مسجلاً يفتح شاشة الدخول
        },
      ),
    );
  }
}
