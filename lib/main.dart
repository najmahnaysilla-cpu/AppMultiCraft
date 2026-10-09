import 'package:flutter/material.dart';
import 'loginpage.dart';

void main() {
  runApp(const MultiCraftApp());
}

class MultiCraftApp extends StatelessWidget {
  const MultiCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MultiCraft',
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/Logo.png',
            width: 180,
          ),
        ),
      ),
    );
  }
}