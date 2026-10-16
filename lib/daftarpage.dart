import 'package:flutter/material.dart';
import 'accountdata.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController usernameController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  bool passwordVisible = false;
  bool agreeTerms = false;

  static const Color purple = Color(0xFF6757E8);

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
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
                                  'Daftar Akun',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Buat akun untuk mulai menggunakan aplikasi',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: purple,
                                    fontSize: 10,
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
                                  controller: usernameController,
                                  hint: 'Nama Pengguna',
                                  iconAsset:
                                      'assets/images/user.png',
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
                                const SizedBox(height: 7),

                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: agreeTerms,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            agreeTerms = value ?? false;
                                          });
                                        },
                                        activeColor: purple,
                                        checkColor: Colors.white,
                                        side: const BorderSide(
                                          color: purple,
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Expanded(
                                      child: Text(
                                        'Saya telah membaca dan menyetujui '
                                        'Syarat Ketentuan dan Kebijakan Privasi',
                                        style: TextStyle(
                                          color: purple,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  height: 38,
                                  child: ElevatedButton(
                                    onPressed: _daftar,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: purple,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Daftar',
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
                              'Sudah punya akun?',
                              style: TextStyle(
                                color: purple,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Masuk disini!',
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

  void _daftar() {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty) {
      _message('Semua data harus diisi.');
      return;
    }

    final emailRegex =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(email)) {
      _message('Masukkan email yang valid.');
      return;
    }

    if (password.length < 6) {
      _message('Kata sandi minimal 6 karakter.');
      return;
    }

    if (!agreeTerms) {
      _message('Centang persetujuan terlebih dahulu.');
      return;
    }

    accountdata.email = email;
    accountdata.username = username;
    accountdata.password = password;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil dibuat. Silakan masuk.'),
      ),
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      Navigator.pop(context);
    });
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}