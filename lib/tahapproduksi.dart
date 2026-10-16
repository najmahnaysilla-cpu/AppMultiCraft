import 'package:flutter/material.dart';
import 'detailtahap.dart';     // Menghubungkan ke halaman detail tahap
import 'tahapcard.dart';     // Menghubungkan ke komponen kartu tahapan

// =====================================================================
// KELAS UTAMA: Mengatur kerangka halaman, data proyek, dan navigasi bawah
// =====================================================================
class TahapanProduksiPage extends StatefulWidget {
  final String username;       // Menerima nama user yang sedang login
  final String productionType; // Menerima jenis produksi (Film / Podcast / Animasi)
  final String projectTitle;   // Menerima judul proyek yang diklik
  final String projectOwner;   // Menerima nama penanggung jawab (PJ)
  final String projectDeadline;// Menerima tenggat waktu proyek

  const TahapanProduksiPage({
    super.key,
    required this.username,
    required this.productionType,
    required this.projectTitle,
    required this.projectOwner,
    required this.projectDeadline,
  });

  @override
  State<TahapanProduksiPage> createState() => _TahapanProduksiPageState();
}

class _TahapanProduksiPageState extends State<TahapanProduksiPage> {
  // Warna utama ungu khas aplikasi
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);

  int selectedNav = 0; // Angka 0 artinya menu beranda yang aktif menyala putih
  
  // Tempat menampung daftar sub-tugas berdasarkan masing-masing kategori tahap produksi
  Map<String, List<Map<String, dynamic>>> tahapTasks = {
    'Pra Produksi': [],
    'Produksi': [],
    'Pasca Produksi': [],
  };

  // Daftar menu navigasi di bagian bawah layar
  final List<Map<String, String>> navItems = const [
    {'name': 'dashboard', 'label': 'Beranda'},
    {'name': 'jadwal', 'label': 'Jadwal'},
    {'name': 'buku', 'label': 'Edukasi'},
    {'name': 'catatan', 'label': 'Catatan'},
    {'name': 'folder', 'label': 'Proyek'},
  ];

  // Rumus untuk mengambil file gambar PNG dari folder aset komputer
  String assetPath(String name) => 'assets/images/$name.png';

  // Rumus untuk memberikan efek timbul (shadow) pada kotak
  BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.10),
        blurRadius: 5,
        offset: const Offset(0, 2),
      );

  // Rumus kotak: Mengatur sudut melengkung, warna latar, garis tepi, dan bayangan
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

  // Ikon cadangan jika file PNG di folder komputer gagal dimuat
  IconData fallbackIcon(String name) {
    switch (name) {
      case 'pengaturan': return Icons.settings_rounded;
      case 'bel': return Icons.notifications_rounded;
      case 'dashboard': return Icons.dashboard_rounded;
      case 'jadwal': return Icons.calendar_month_rounded;
      case 'buku': return Icons.menu_book_rounded;
      case 'catatan': return Icons.note_alt_outlined;
      case 'folder': return Icons.folder_outlined;
      default: return Icons.image_outlined;
    }
  }

  // Fungsi untuk menampilkan gambar PNG dari folder aset
  Widget assetIcon(String name, {double size = 20, Color? color}) {
    return Image.asset(
      assetPath(name),
      width: size, height: size, fit: BoxFit.contain,
      color: color,
      colorBlendMode: color == null ? null : BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) {
        return Icon(fallbackIcon(name), size: size, color: color ?? purple);
      },
    );
  }

  // Desain tombol kecil di pojok kanan atas header
  Widget headerButton(String name, VoidCallback onTap) {
    return Container(
      width: 35, height: 35,
      decoration: shape(color: Colors.white, radius: 10),
      child: IconButton(padding: EdgeInsets.zero, onPressed: onTap, icon: assetIcon(name, size: 19)),
    );
  }

  // Membuka halaman rincian sub-tugas dan menangkap data hasil perubahan user
  void openDetailTahap(String tahapNama) async {
    final updatedTasks = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailTahapPage(
          username: widget.username,
          tahapNama: tahapNama,
          projectTitle: widget.projectTitle,
          initialTasks: tahapTasks[tahapNama] ?? [],
        ),
      ),
    );

    // Jika user kembali dan membawa data tugas baru, simpan perubahannya pakai setState
    if (updatedTasks != null) {
      setState(() {
        tahapTasks[tahapNama] = updatedTasks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan ikon kategori yang cocok berdasarkan jenis produksi proyek
    final String categoryIconName = widget.productionType.toLowerCase().contains('film')
        ? 'film'
        : widget.productionType.toLowerCase().contains('podcast')
            ? 'podcast'
            : 'animasi';

    // Mengatur aksi saat tombol kembali (back) di HP ditekan
    return WillPopScope(
      onWillPop: () async {
        int totalAllTasks = 0;
        int doneAllTasks = 0;

        // Menghitung total semua tugas dari semua tahapan
        tahapTasks.forEach((key, tasks) {
          totalAllTasks += tasks.length;
          doneAllTasks += tasks.where((t) => t['isDone'] == true).length;
        });

        double overallProgress = totalAllTasks == 0 ? 0.0 : doneAllTasks / totalAllTasks;

        // Mengirim data jumlah tugas dan progress kembali ke halaman sebelumnya
        Navigator.pop(context, {
          'tasksCount': totalAllTasks,
          'progress': overallProgress,
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // =================================================================
              // [BAGIAN ATAS]: Header Judul Proyek dan Tombol Kembali
              // =================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                decoration: const BoxDecoration(
                  color: purple,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    // Tombol Panah Kembali (Back) manual
                    Container(
                      width: 35, height: 35,
                      decoration: shape(color: Colors.white, radius: 10),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          int totalAllTasks = 0;
                          int doneAllTasks = 0;
                          tahapTasks.forEach((key, tasks) {
                            totalAllTasks += tasks.length;
                            doneAllTasks += tasks.where((t) => t['isDone'] == true).length;
                          });
                          double overallProgress = totalAllTasks == 0 ? 0.0 : doneAllTasks / totalAllTasks;

                          Navigator.pop(context, {'tasksCount': totalAllTasks, 'progress': overallProgress});
                        },
                        icon: const Icon(Icons.arrow_back, color: purple, size: 19),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Kotak Judul Proyek di Tengah Header
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: shape(color: Colors.white, radius: 20),
                        child: Text(
                          '${widget.productionType} : ${widget.projectTitle}',
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    headerButton('bel', () {}),
                    const SizedBox(width: 8),
                    headerButton('pengaturan', () {}),
                  ],
                ),
              ),

              // =================================================================
              // [BAGIAN ISI]: Kartu Ringkasan Proyek & 3 Kotak Kartu Tahapan
              // =================================================================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                  child: Column(
                    children: [
                      // [Kartu Informasi Utama Proyek]
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: shape(color: purple, radius: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: shape(color: Colors.white, radius: 6),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      assetIcon(categoryIconName, size: 14, color: purple),
                                      const SizedBox(width: 4),
                                      Text(widget.productionType, style: const TextStyle(color: purple, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: shape(color: Colors.white, radius: 6),
                                  child: const Text('Dalam Proses', style: TextStyle(color: purple, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(widget.projectTitle, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            const Divider(color: Colors.white30, height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.projectOwner, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                                Text('Target : ${widget.projectDeadline}', style: const TextStyle(color: Colors.white70, fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Tulisan Label Judul Tahapan Produksi
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: shape(color: Colors.white, radius: 10, border: Border.all(color: purple, width: 1.5)),
                        child: const Text('[ TAHAPAN PRODUKSI ]', style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),

                      const SizedBox(height: 14),

                      // [Memanggil Widget Kartu Tahapan dari file tahapcard.dart]
                      TahapCardWidget(
                        title: 'Pra Produksi',
                        tasks: tahapTasks['Pra Produksi']!,
                        onTapDetail: () => openDetailTahap('Pra Produksi'),
                        shape: shape,
                        purple: purple,
                      ),
                      const SizedBox(height: 12),
                      TahapCardWidget(
                        title: 'Produksi',
                        tasks: tahapTasks['Produksi']!,
                        onTapDetail: () => openDetailTahap('Produksi'),
                        shape: shape,
                        purple: purple,
                      ),
                      const SizedBox(height: 12),
                      TahapCardWidget(
                        title: 'Pasca Produksi',
                        tasks: tahapTasks['Pasca Produksi']!,
                        onTapDetail: () => openDetailTahap('Pasca Produksi'),
                        shape: shape,
                        purple: purple,
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================================
              // [BAGIAN BAWAH]: Menu Navigasi (Ikon aktif menyala putih bersih)
              // =================================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: shape(color: purple, radius: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(navItems.length, (index) {
                      final item = navItems[index];
                      final active = selectedNav == index;
                      final Color iconColor = active ? Colors.white : lightPurple;

                      return InkWell(
                        onTap: () {
                          setState(() => selectedNav = index);
                          if (index == 0) {
                            int totalAllTasks = 0;
                            int doneAllTasks = 0;
                            tahapTasks.forEach((key, tasks) {
                              totalAllTasks += tasks.length;
                              doneAllTasks += tasks.where((t) => t['isDone'] == true).length;
                            });
                            double overallProgress = totalAllTasks == 0 ? 0.0 : doneAllTasks / totalAllTasks;

                            Navigator.pop(context, {'tasksCount': totalAllTasks, 'progress': overallProgress});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Menu ${item['label']} dipilih')));
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: assetIcon(item['name']!, size: 24, color: iconColor),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}