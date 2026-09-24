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

      // Halaman pertama yang muncul
      home: const SplashPage(),
    );
  }
}

// ===============================
// HALAMAN AWAL / SPLASH
// ===============================
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF182BB5),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Kotak logo
                Container(
                  width: 125,
                  height: 115,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // Logo dari folder assets
                      Image.asset(
                        'assets/images/logo.png',
                        width: 65,
                        height: 55,
                        fit: BoxFit.contain,
                      ),

                     
                    ],
                  ),
                ),

                const SizedBox(height: 23),

                // Tombol Mulai
                SizedBox(
                  width: 165,
                  height: 42,

                  child: ElevatedButton(
                    onPressed: () {

                      // Pindah ke halaman Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF182BB5),
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),

                    child: const Text(
                      'Mulai',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}