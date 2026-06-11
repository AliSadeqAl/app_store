import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب جديد")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add_alt, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "البريد الإلكتروني", border: OutlineInputBorder()),
                  validator: (val) => val!.contains('@') ? null : "يرجى إدخال بريد إلكتروني صالح يحتوي على @",
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "كلمة المرور", border: OutlineInputBorder()),
                  validator: (val) => val!.length >= 6 ? null : "كلمة المرور يجب أن لا تقل عن 6 أحرف",
                ),
                const SizedBox(height: 25),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50), 
                          backgroundColor: Colors.blue, 
                          foregroundColor: Colors.white
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            String? error = await provider.registerWithEmail(
                              _emailController.text.trim(), 
                              _passwordController.text.trim()
                            );
                            setState(() => _isLoading = false);
                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error), backgroundColor: Colors.red)
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("تم تسجيل الحساب بنجاح! قم بتسجيل الدخول الآن"), backgroundColor: Colors.green)
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text("تسجيل الحساب", style: TextStyle(fontSize: 18)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
