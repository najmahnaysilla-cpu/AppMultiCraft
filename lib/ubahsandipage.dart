import 'package:flutter/material.dart';

// [KODE UBAH SANDI]: Halaman untuk mengganti kata sandi akun
class UbahKataSandiPage extends StatelessWidget {
  const UbahKataSandiPage({super.key});

  static const Color purple = Color(0xFF6757E8);

  // [RUMUS KOTAK]: Membuat sudut melengkung dan bayangan
  BoxDecoration shape({Color color = Colors.white, double radius = 12, Border? border}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, offset: const Offset(0, 2))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // [HEADER ATAS]: Tombol kembali dan judul halaman
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              decoration: const BoxDecoration(color: purple),
              child: Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: shape(color: Colors.white, radius: 10),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: purple, size: 19),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: shape(color: Colors.white, radius: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, size: 16, color: purple),
                          SizedBox(width: 8),
                          Text('Ubah Kata Sandi', style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // [KOTAK INPUT FORMULIR]: Input sandi lama, sandi baru, dan konfirmasi
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.lock_outline, size: 50, color: purple),
                        SizedBox(height: 8),
                        Text('Ubah Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: purple)),
                        Text('Masukkan kata sandi lama dan kata sandi baru untuk melanjutkan', style: TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Kata Sandi Lama', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(obscureText: true, decoration: inputDec('Masukkan Kata Sandi')),
                  const SizedBox(height: 12),
                  const Text('Kata Sandi Baru', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(obscureText: true, decoration: inputDec('Masukkan Kata Sandi')),
                  const SizedBox(height: 12),
                  const Text('Konfirmasi Kata Sandi Baru', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(obscureText: true, decoration: inputDec('Masukkan Kata Sandi')),
                  const SizedBox(height: 24),
                  // Tombol simpan password baru
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // [DESAIN INPUT SANDI]: Dekorasi kotak teks password
  InputDecoration inputDec(String hint) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.lock_open, size: 16, color: Colors.grey),
      suffixIcon: const Icon(Icons.visibility_off, size: 16, color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFFF5F4FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
    );
  }
}