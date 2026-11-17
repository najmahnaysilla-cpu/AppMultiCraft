import 'dart:async'; // Diperlukan untuk Timer
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'notification_helper.dart'; // Mengimpor layanan notifikasi lokal

void main() async {
  // Wajib dipanggil sebelum melakukan inisialisasi asynchronous
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menginisialisasi layanan notifikasi lokal saat aplikasi pertama kali dibuka
  await NotificationService.init();

  runApp(const MultiCraftApp());
}

class MultiCraftApp extends StatelessWidget {
  const MultiCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MultiCraft',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    
    // Timer untuk mengatur durasi splash screen (2 detik / 2000 milidetik)
    Timer(const Duration(seconds: 2), () {
      // Setelah 2 detik, otomatis pindah ke LoginPage dan menggantikan SplashPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Animasi fade in dan scale halus untuk logo
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: child,
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