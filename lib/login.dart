import 'package:app_store/register.dart';
import 'package:app_store/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "البريد الإلكتروني", border: OutlineInputBorder()),
                  validator: (val) => val!.trim().isNotEmpty ? null : "يرجى إدخال البريد الإلكتروني",
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "كلمة المرور", border: OutlineInputBorder()),
                  validator: (val) => val!.isNotEmpty ? null : "يرجى إدخال كلمة المرور",
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
                            String? error = await provider.loginWithEmail(
                              _emailController.text.trim(), 
                              _passwordController.text.trim()
                            );
                            setState(() => _isLoading = false);
                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error), backgroundColor: Colors.red)
                              );
                            }
                          }
                        },
                        child: const Text("دخول", style: TextStyle(fontSize: 18)),
                      ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())),
                  child: const Text("لا تملك حساباً؟ سجل الآن الحساب الجديد"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
