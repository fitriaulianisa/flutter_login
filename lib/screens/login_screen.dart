import 'package:flutter/material.dart';
import 'package:flutter_login/data/user_data.dart';
import 'package:flutter_login/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: 1.Logo Aplikasi
              SizedBox(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //TODO: 2. TextField email dan password
              const SizedBox(height: 16),
              // text field untuk email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              // text fiels untuk password
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText:
                    true, // ini agar password tidak kelihatan ketika diketik
              ),
              //TODO: 3. Tombol Login
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    if (validateLogin(email, password)) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      await prefs.setString('email', email);
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Invalid email pr password')));
                    }
                  },
                  child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }

  bool validateLogin(String email, String password) {
    for (User user in userList) {
      if (user.email == email && user.password == password) {
        return true;
      }
    }
    return false;
  }
}
