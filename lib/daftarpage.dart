import 'package:flutter/material.dart';
import 'accountdata.dart';

// ========================================
// HALAMAN DAFTAR AKUN
// ========================================

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  // Controller untuk mengambil data dari setiap input
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // Untuk menampilkan / menyembunyikan password
  bool passwordVisible = false;

  // Untuk checkbox persetujuan
  bool agree = false;

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
      backgroundColor: const Color(0xFFB7C5F4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // =================================
              // HEADER
              // =================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.fromLTRB(
                  15,
                  10,
                  15,
                  32,
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

                    const SizedBox(height: 13),

                    const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // =================================
              // FORM DAFTAR
              // =================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  26,
                  32,
                  26,
                  20,
                ),

                child: Column(
                  children: [

                    // EMAIL
                    _inputBox(
                      controller: emailController,
                      hint: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType:
                          TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 8),

                    // USERNAME
                    _inputBox(
                      controller: usernameController,
                      hint: 'Username',
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 8),

                    // PASSWORD
                    _inputBox(
                      controller: passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,

                      obscureText: !passwordVisible,

                      suffixIcon: IconButton(
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

                    const SizedBox(height: 8),

                    // =================================
                    // PERSETUJUAN
                    // =================================

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        SizedBox(
                          width: 18,
                          height: 18,

                          child: Checkbox(
                            value: agree,

                            onChanged: (value) {

                              setState(() {
                                agree =
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

                        const SizedBox(width: 4),

                        const Expanded(
                          child: Text(
                            'Saya telah membaca dan menyetujui '
                            'Syarat Ketentuan & Kebijakan Privasi',

                            style: TextStyle(
                              color: Color(0xFF182BB5),
                              fontSize: 7,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // =================================
                    // TOMBOL DAFTAR
                    // =================================

                    SizedBox(
                      width: double.infinity,
                      height: 37,

                      child: ElevatedButton(
                        onPressed: _register,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF182BB5),

                          elevation: 2,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(11),
                          ),
                        ),

                        child: const Text(
                          'Daftar',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 160),

                    // =================================
                    // KEMBALI KE LOGIN
                    // =================================

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Sudah punya akun? Log in',

                        style: TextStyle(
                          color: Color(0xFF182BB5),
                          fontSize: 8,
                        ),
                      ),
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
  // KOMPONEN INPUT
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
          borderRadius: BorderRadius.circular(11),
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
  // FUNGSI DAFTAR
  // ========================================

  void _register() {

    // Mengecek apakah semua input sudah diisi
    if (emailController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lengkapi semua data terlebih dahulu.',
          ),
        ),
      );

      return;
    }

    // Mengecek checkbox persetujuan
    if (!agree) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Centang persetujuan terlebih dahulu.',
          ),
        ),
      );

      return;
    }

    // Menyimpan data akun baru
    accountdata.email =
        emailController.text.trim();

    accountdata.username =
        usernameController.text.trim();

    accountdata.password =
        passwordController.text;

    // Kembali ke halaman login
    Navigator.pop(context);

    // Setelah kembali, user bisa login
    // menggunakan akun yang baru dibuat.
  }
}