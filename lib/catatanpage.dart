import 'package:flutter/material.dart';
import 'edukasipage.dart';
import 'jadwalpage.dart';
import 'folderpage.dart';

class CatatanPage extends StatefulWidget {
  final String username;
  final List<Map<String, dynamic>> projects;

  const CatatanPage({
    super.key,
    required this.username,
    required this.projects,
  });

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);

  int selectedNav = 3; // Indeks 3 untuk Catatan

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
    int totalTasksCount = widget.projects.fold(0, (sum, project) => sum + ((project['tasks'] as int?) ?? 0));

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
                    child: const Icon(Icons.person, color: purple, size: 29),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Selamat Datang!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 3),
                        Text(
                          widget.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  headerButton('bel', () => showMessage('Tidak ada notifikasi baru.')),
                  const SizedBox(width: 8),
                  headerButton('pengaturan', () => showMessage('Menu Pengaturan')),
                ],
              ),
            ),

            // KONTEN UTAMA SESUAI GAMBAR KANAN
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                child: Column(
                  children: [
                    // KOTAK JUDUL: [ DAFTAR TUGAS GLOBAL ] DENGAN BADGE JUMLAH SUB TUGAS
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                      decoration: shape(color: purple, radius: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '[ DAFTAR TUGAS GLOBAL ]',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Seluruh checklist sub-tugas dari semua proyek.',
                                style: TextStyle(color: Colors.white70, fontSize: 8),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: shape(color: Colors.white, radius: 6),
                            child: Text(
                              '$totalTasksCount Sub Tugas',
                              style: const TextStyle(color: purple, fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // GRID 2 KOLOM MENGIKUTI DATA PROYEK
                    if (widget.projects.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.projects.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.85,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      project['status'] ?? 'Pra Produksi',
                                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                                    ),
                                    Text(
                                      project['deadline'] ?? '-',
                                      style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  project['title'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: purple),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    project['owner'] ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 9, color: Colors.black54, fontWeight: FontWeight.w600),
                                  ),
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
                            'Belum ada proyek atau tugas yang ditambahkan.',
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
                            MaterialPageRoute(builder: (_) => JadwalPage(username: widget.username, projects: widget.projects)),
                          );
                        } else if (index == 2) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => EdukasiPage(username: widget.username)),
                          );
                        } else if (index == 3) {
                          return;
                        } else if (index == 4) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => FolderPage(username: widget.username, projects: widget.projects)),
                          );
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
    );
  }
}