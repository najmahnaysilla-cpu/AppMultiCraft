import 'package:flutter/material.dart';
import 'accountdata.dart';

// ========================================
// HALAMAN LUPA PASSWORD
// ========================================

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() =>
      _LupaPasswordPageState();
}

class _LupaPasswordPageState
    extends State<LupaPasswordPage> {

  // Controller untuk mengambil email yang diketik
  final TextEditingController emailController =
      TextEditingController();

  // Menentukan apakah pesan berhasil sudah muncul
  bool emailSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF182BB5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =================================
              // TOMBOL KEMBALI
              // =================================

              Align(
                alignment: Alignment.centerLeft,

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

              const SizedBox(height: 72),

              // =================================
              // JUDUL
              // =================================

              const Text(
                'Lupa Password?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                'Masukkan email untuk reset password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              // =================================
              // PESAN EMAIL BERHASIL
              // =================================

              if (emailSent)
                Container(
                  width: double.infinity,

                  margin: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),

                  padding: const EdgeInsets.all(8),

                  color: const Color(0xFFD6D83F),

                  child: const Text(
                    'Kami sudah mengirim surel yang berisi '
                    'tautan untuk mereset kata sandi anda',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (emailSent)
                const SizedBox(height: 16),

              // =================================
              // INPUT EMAIL
              // =================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),

                child: TextField(
                  controller: emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  style: const TextStyle(
                    color: Color(0xFF182BB5),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    hintText: 'Email',

                    hintStyle: const TextStyle(
                      color: Color(0xFF182BB5),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF182BB5),
                      size: 15,
                    ),

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
                ),
              ),

              const SizedBox(height: 15),

              // =================================
              // TOMBOL KIRIM
              // =================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),

                child: SizedBox(
                  width: double.infinity,
                  height: 37,

                  child: ElevatedButton(
                    onPressed: _sendEmail,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: emailSent
                          ? const Color(0xFFD6D83F)
                          : const Color(0xFFB7C5F4),

                      foregroundColor:
                          const Color(0xFF182BB5),

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                    ),

                    child: const Text(
                      'Kirim',

                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // =================================
              // KEMBALI KE LOGIN
              // =================================

              if (emailSent)
                const SizedBox(height: 15),

              if (emailSent)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    '< Kembali ke halaman login',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================
  // FUNGSI KIRIM EMAIL
  // ========================================

  void _sendEmail() {

    // Kalau email masih kosong
    if (emailController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan email terlebih dahulu.',
          ),
        ),
      );

      return;
    }

    // Mengecek apakah email terdaftar
    if (emailController.text.trim() !=
        accountdata.email) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email belum terdaftar.',
          ),
        ),
      );

      return;
    }

    // Kalau email benar
    setState(() {
      emailSent = true;
    });
  }
}