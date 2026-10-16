import 'package:flutter/material.dart';
import 'jadwalpage.dart';
import 'catatanpage.dart';
import 'edukasipage.dart';

class FolderPage extends StatefulWidget {
  final String username;
  final List<Map<String, dynamic>> projects; // Menerima data proyek secara dinamis

  const FolderPage({
    super.key,
    required this.username,
    required this.projects,
  });

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);

  int selectedNav = 4; // Indeks 4 untuk menu Folder/Proyek agar ikonnya menyala putih

  final List<Map<String, String>> navItems = const [
    {'name': 'dashboard', 'label': 'Beranda'},
    {'name': 'jadwal', 'label': 'Jadwal'},
    {'name': 'buku', 'label': 'Edukasi'},
    {'name': 'catatan', 'label': 'Catatan'},
    {'name': 'folder', 'label': 'Proyek'},
  ];

  String assetPath(String name) => 'assets/images/$name.png';

  BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.10),
        blurRadius: 5,
        offset: const Offset(0, 2),
      );

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

  IconData fallbackIcon(String name) {
    switch (name) {
      case 'pengaturan':
        return Icons.settings_rounded;
      case 'bel':
        return Icons.notifications_rounded;
      case 'dashboard':
        return Icons.dashboard_rounded;
      case 'jadwal':
        return Icons.calendar_month_rounded;
      case 'buku':
        return Icons.menu_book_rounded;
      case 'catatan':
        return Icons.note_alt_outlined;
      case 'folder':
        return Icons.folder_outlined;
      default:
        return Icons.image_outlined;
    }
  }

  Widget assetIcon(String name, {double size = 20, Color? color}) {
    return Image.asset(
      assetPath(name),
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
      colorBlendMode: color == null ? null : BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) {
        return Icon(fallbackIcon(name), size: size, color: color ?? purple);
      },
    );
  }

  void showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

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
    int totalFilesCount = widget.projects.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER PROFIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
              decoration: const BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: shape(color: Colors.white, radius: 21),
                    child: const Icon(
                      Icons.person,
                      color: purple,
                      size: 29,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  headerButton('bel', () {
                    showMessage('Tidak ada notifikasi baru.');
                  }),
                  const SizedBox(width: 8),
                  headerButton('pengaturan', () {
                    showMessage('Menu Pengaturan');
                  }),
                ],
              ),
            ),

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                child: Column(
                  children: [
                    // KOTAK JUDUL BERKAS & MANAJEMEN ASET
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: shape(color: purple, radius: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '[ BERKAS & MANAJEMEN ASET PRODUKSI ]',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: shape(color: Colors.white, radius: 6),
                            child: Text(
                              '$totalFilesCount File',
                              style: const TextStyle(
                                color: purple,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // GRID DAFTAR 2 KOLOM MENGIKUTI DATA PROYEK
                    if (widget.projects.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.projects.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.45,
                        ),
                        itemBuilder: (context, index) {
                          final project = widget.projects[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: shape(
                              color: Colors.white,
                              radius: 10,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.insert_drive_file, size: 14, color: Colors.redAccent),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        project['title'] ?? 'Berkas Proyek',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Proyek: ${project['type']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.black54,
                                    height: 1.2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        project['status'] ?? 'Pra Produksi',
                                        style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => showMessage('Mengunduh berkas...'),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                        decoration: shape(color: purple, radius: 6),
                                        child: const Text(
                                          'Unduh',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    else
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            'Belum ada berkas atau proyek yang ditambahkan.',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // NAVIGASI BAWAH
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
                          Navigator.pop(context);
                        } else if (index == 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => JadwalPage(
                                username: widget.username,
                                projects: widget.projects,
                              ),
                            ),
                          );
                        } else if (index == 2) {
                          showMessage('Menu Edukasi');
                        } else if (index == 3) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CatatanPage(
                                username: widget.username,
                                projects: widget.projects,
                              ),
                            ),
                          );
                        } else if (index == 4) {
                          return;
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: assetIcon(
                          item['name']!,
                          size: 24,
                          color: iconColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}