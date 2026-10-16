import 'package:flutter/material.dart';
import 'detailpanduan.dart'; // Menghubungkan ke halaman detail panduan
import 'notifikasipage.dart';
import 'pengaturanpage.dart';

// =====================================================================
// KELAS PANDUAN PAGE: Halaman utama modul panduan (Pilih Kategori)
// =====================================================================
class PanduanPage extends StatefulWidget {
  final String username; // Menerima nama pengguna yang sedang aktif

  const PanduanPage({
    super.key,
    required this.username,
  });

  @override
  State<PanduanPage> createState() => _PanduanPageState();
}

class _PanduanPageState extends State<PanduanPage> {
  // Warna ungu khas aplikasi
  static const Color purple = Color(0xFF6757E8);

  // Efek bayangan halus pada card
  BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 4,
        offset: const Offset(0, 2),
      );

  // Dekorasi sudut melengkung dan bayangan kotak
  BoxDecoration shape({
    Color color = Colors.white,
    double radius = 12,
    Border? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      boxShadow: [softShadow],
    );
  }

  // Mengambil direktori file aset gambar
  String assetPath(String name) => 'assets/images/$name.png';

  // Icon cadangan jika file gambar di assets tidak ditemukan
  IconData fallbackIcon(String name) {
    switch (name) {
      case 'pengaturan':
        return Icons.settings_rounded;
      case 'bel':
        return Icons.notifications_rounded;
      case 'film':
        return Icons.movie_outlined;
      case 'podcast':
        return Icons.mic_none_rounded;
      case 'animasi':
        return Icons.animation_outlined;
      default:
        return Icons.image_outlined;
    }
  }

  // Pemuat gambar aset dengan pengaman errorBuilder
  Widget assetIcon(String name, {double size = 20, Color? color}) {
    return Image.asset(
      assetPath(name),
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
      colorBlendMode: color == null ? null : BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          fallbackIcon(name),
          size: size,
          color: color ?? purple,
        );
      },
    );
  }

  // Tombol navigasi ikon di header atas
  Widget headerButton(String name, VoidCallback onTap) {
    return Container(
      width: 35,
      height: 35,
      decoration: shape(color: Colors.white, radius: 10),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: assetIcon(name, size: 19),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. HEADER ATAS (Profil Pengguna & Tombol Ikon)
            // =========================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
              decoration: BoxDecoration(
                color: purple,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [softShadow],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: shape(color: Colors.white, radius: 21),
                    child: const Icon(Icons.person, color: purple, size: 29),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  headerButton('bel', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotifikasiPage(
                          username: widget.username,
                          projects: const [],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  headerButton('pengaturan', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PengaturanPage(
                          username: widget.username,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // =========================================================
            // 2. TOMBOL KEMBALI DI KIRI ATAS
            // =========================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_back, color: purple, size: 24),
                ),
              ),
            ),

            // =========================================================
            // 3. KONTEN UTAMA (Dinaikkan agar proporsional di atas)
            // =========================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'PANDUAN',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: purple,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pilih bidang yang ingin diketahui',
                      style: TextStyle(
                        fontSize: 11,
                        color: purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Tombol Kategori: Film
                    _buildCategoryButton(
                      title: 'FILM',
                      assetName: 'film',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPanduanPage(
                              username: widget.username,
                              categoryTitle: 'Film',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tombol Kategori: Podcast
                    _buildCategoryButton(
                      title: 'PODCAST',
                      assetName: 'podcast',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPanduanPage(
                              username: widget.username,
                              categoryTitle: 'Podcast',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tombol Kategori: Animasi
                    _buildCategoryButton(
                      title: 'ANIMASI',
                      assetName: 'animasi',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPanduanPage(
                              username: widget.username,
                              categoryTitle: 'Animasi',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // [Helper Tombol Kategori]: Membentuk tombol kategori yang rapi
  Widget _buildCategoryButton({
    required String title,
    required String assetName,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: shape(color: purple, radius: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              assetIcon(assetName, size: 22, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}