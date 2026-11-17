import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'daftarpage.dart';
import 'lupapassword.dart';
import 'edukasipage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool isLoading = false;

  static const Color purple = Color(0xFF6757E8);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 360,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Masuk',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Masuk ke akun Anda untuk melanjutkan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 18),

                                // Input Email / Username
                                _inputBox(
                                  controller: emailController,
                                  hint: 'Email atau Nama Pengguna',
                                  iconAsset: 'assets/images/email.png',
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(height: 10),

                                // Input Password
                                _inputBox(
                                  controller: passwordController,
                                  hint: 'Kata Sandi',
                                  iconAsset: 'assets/images/gembok.png',
                                  obscureText: !passwordVisible,
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: purple,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Lupa Kata Sandi
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LupaPasswordPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Lupa kata sandi?',
                                      style: TextStyle(
                                        color: purple,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Tombol Masuk
                                SizedBox(
                                  width: double.infinity,
                                  height: 38,
                                  child: ElevatedButton(
                                    onPressed: isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: purple,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text(
                                            'Masuk',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Belum punya akun? Daftar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun?',
                              style: TextStyle(
                                color: purple,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DaftarPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Daftar disini!',
                                style: TextStyle(
                                  color: purple,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _inputBox({
    required TextEditingController controller,
    required String hint,
    required String iconAsset,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 38,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: purple,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
            color: purple,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(11),
            child: Image.asset(
              iconAsset,
              width: 14,
              height: 14,
              fit: BoxFit.contain,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 38,
            minHeight: 38,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 8,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: purple,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
              color: purple,
              width: 1.8,
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi Login yang terhubung ke PHP backend via IP 192.168.1.9
  Future<void> _login() async {
    final emailOrUsername = emailController.text.trim();
    final password = passwordController.text;

    if (emailOrUsername.isEmpty || password.isEmpty) {
      _message('Email/Username dan password harus diisi.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.9/multicraft/api/login.php'),
        body: {
          'identifier': emailOrUsername,
          'password': password,
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          // Diubah dari 'username' ke 'nama' sesuai database dan file login.php
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EdukasiPage(
                username: data['data']['nama'] ?? 'Pengguna',
              ),
            ),
          );
        } else {
          _message(data['message'] ?? 'Email atau password salah.');
        }
      } else {
        _message('Terjadi kesalahan pada server.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _message('Gagal terhubung ke server: $e');
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}