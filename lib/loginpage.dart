import 'package:flutter/material.dart';
import 'accountdata.dart';
import 'daftarpage.dart';
import 'lupapassword.dart';
import 'edukasipage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  bool passwordVisible = false;

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
                                  'Selamat Datang!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Masuk untuk melanjutkan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 18),

                                _inputBox(
                                  controller: emailController,
                                  hint: 'Email',
                                  iconAsset:
                                      'assets/images/email.png',
                                  keyboardType:
                                      TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 10),

                                _inputBox(
                                  controller: passwordController,
                                  hint: 'Kata Sandi',
                                  iconAsset:
                                      'assets/images/gembok.png',
                                  obscureText: !passwordVisible,
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible =
                                            !passwordVisible;
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
                                const SizedBox(height: 8),

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
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 13),

                                SizedBox(
                                  width: double.infinity,
                                  height: 38,
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 227, 87, 232),
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
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
                                    builder: (context) =>
                                        const DaftarPage(),
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
          color: Color.fromARGB(255, 223, 122, 189),
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

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _message('Email dan password harus diisi.');
      return;
    }

    if (email == accountdata.email &&
        password == accountdata.password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EdukasiPage(
            username: accountdata.username,
  
          ),
        ),
      );
    } else {
      _message('Email atau password salah.');
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
