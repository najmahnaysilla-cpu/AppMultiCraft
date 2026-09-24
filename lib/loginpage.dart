import 'package:flutter/material.dart';

import 'accountdata.dart';
import 'daftarpage.dart';
import 'lupapassword.dart';
import 'edukasipage.dart';

// ========================================
// HALAMAN LOGIN
// ========================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controller untuk mengambil isi email
  final TextEditingController emailController =
      TextEditingController();

  // Controller untuk mengambil isi password
  final TextEditingController passwordController =
      TextEditingController();

  // Untuk menampilkan / menyembunyikan password
  bool passwordVisible = false;

  // Untuk checkbox "Ingat saya"
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7C5F4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =================================
              // HEADER BIRU
              // =================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.fromLTRB(
                  15,
                  10,
                  15,
                  27,
                ),

                decoration: const BoxDecoration(
                  color: Color(0xFF182BB5),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),

                child: Column(
                  children: [

                    // Tombol kembali
                    Align(
                      alignment: Alignment.centerLeft,

                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,

                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 21,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      'Masuk untuk melanjutkan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // =================================
              // FORM LOGIN
              // =================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  26,
                  40,
                  26,
                  20,
                ),

                child: Column(
                  children: [

                    // =================================
                    // EMAIL
                    // =================================

                    _inputBox(
                      controller: emailController,
                      hint: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType:
                          TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 8),

                    // =================================
                    // PASSWORD
                    // =================================

                    _inputBox(
                      controller: passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,

                      // Password disembunyikan
                      // kalau passwordVisible = false
                      obscureText: !passwordVisible,

                      // Tombol mata
                      suffixIcon: MouseRegion(
                        cursor: SystemMouseCursors.click,

                        child: IconButton(
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

                            color:
                                const Color(0xFF182BB5),

                            size: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =================================
                    // INGAT SAYA + LUPA PASSWORD
                    // =================================

                    Row(
                      children: [

                        // Checkbox
                        SizedBox(
                          width: 18,
                          height: 18,

                          child: Checkbox(
                            value: rememberMe,

                            onChanged: (value) {
                              setState(() {
                                rememberMe =
                                    value ?? false;
                              });
                            },

                            activeColor:
                                const Color(0xFF182BB5),

                            materialTapTargetSize:
                                MaterialTapTargetSize
                                    .shrinkWrap,
                          ),
                        ),

                        const SizedBox(width: 3),

                        const Text(
                          'Ingat saya',
                          style: TextStyle(
                            color: Color(0xFF182BB5),
                            fontSize: 8,
                          ),
                        ),

                        const Spacer(),

                        // =================================
                        // LUPA PASSWORD
                        // =================================

                        MouseRegion(
                          cursor: SystemMouseCursors.click,

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
                              'Lupa password?',

                              style: TextStyle(
                                color:
                                    Color(0xFF182BB5),
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    // =================================
                    // TOMBOL MASUK
                    // =================================

                    SizedBox(
                      width: double.infinity,
                      height: 37,

                      child: ElevatedButton(
                        onPressed: _login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF182BB5),

                          foregroundColor:
                              Colors.white,

                          elevation: 2,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(11),
                          ),
                        ),

                        child: const Text(
                          'Masuk',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 118),

                    // =================================
                    // DAFTAR AKUN
                    // =================================

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        const Text(
                          'Belum punya akun?',

                          style: TextStyle(
                            color: Color(0xFF182BB5),
                            fontSize: 8,
                          ),
                        ),

                        const SizedBox(width: 2),

                        // Daftar disini
                        MouseRegion(
                          cursor:
                              SystemMouseCursors.click,

                          child: GestureDetector(
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
                                color:
                                    Color(0xFF182BB5),
                                fontSize: 8,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================
  // KOTAK INPUT
  // ========================================

  Widget _inputBox({
    required TextEditingController controller,
    required String hint,
    required IconData icon,

    bool obscureText = false,

    TextInputType? keyboardType,

    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      style: const TextStyle(
        color: Color(0xFF182BB5),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),

      decoration: InputDecoration(
        filled: true,

        fillColor: Colors.white,

        hintText: hint,

        hintStyle: const TextStyle(
          color: Color(0xFF182BB5),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF182BB5),
          size: 15,
        ),

        suffixIcon: suffixIcon,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(11),

          borderSide: BorderSide.none,
        ),

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 11,
        ),
      ),
    );
  }

  // ========================================
  // FUNGSI LOGIN
  // ========================================

  void _login() {

    // Mengecek email dan password
    if (emailController.text.trim() ==
            accountdata.email &&
        passwordController.text ==
            accountdata.password) {

      // Kalau benar,
      // masuk ke halaman edukasi
      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (context) => EdukasiPage(
            username: accountdata.username,
          ),
        ),
      );

    } else {

      // Kalau salah,
      // tampilkan pesan
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Email atau password salah.',
          ),
        ),
      );
    }
  }
}