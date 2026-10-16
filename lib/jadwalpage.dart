import 'package:flutter/material.dart';
import 'edukasipage.dart';
import 'catatanpage.dart';
import 'folderpage.dart';

class JadwalPage extends StatefulWidget {
  final String username;
  final List<Map<String, dynamic>> projects;

  const JadwalPage({
    super.key,
    required this.username,
    required this.projects,
  });

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);

  int selectedNav = 1; // Indeks 1 untuk Jadwal

  // Menyimpan bulan dan tahun yang sedang dilihat di kalender
  late DateTime displayedMonth;

  @override
  void initState() {
    super.initState();
    displayedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

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

  String getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }

  // Mengubah string tanggal "d/M/yyyy" menjadi objek DateTime untuk pencocokan kalender
  DateTime? parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final projectsWithDeadline = widget.projects
        .where((p) => (p['deadline'] as String? ?? '').isNotEmpty)
        .toList();

    // Mengumpulkan daftar tanggal deadline dari proyek (format DateTime tanpa jam)
    final Set<String> deadlineDateKeys = {};
    for (var p in projectsWithDeadline) {
      final dt = parseDate(p['deadline']);
      if (dt != null) {
        deadlineDateKeys.add('${dt.year}-${dt.month}-${dt.day}');
      }
    }

    // Menghitung hari dalam bulan yang sedang ditampilkan
    final daysInMonth = DateUtils.getDaysInMonth(displayedMonth.year, displayedMonth.month);
    final firstDayOfWeek = DateTime(displayedMonth.year, displayedMonth.month, 1).weekday % 7; // Minggu = 0

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

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                child: Column(
                  children: [
                    // KOTAK JUDUL: [ JADWAL KALENDER PRODUKSI ]
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: shape(color: purple, radius: 12),
                      child: const Text(
                        '[ JADWAL KALENDER PRODUKSI ]',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // WIDGET KALENDER DINAMIS
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: shape(color: Colors.white, radius: 12, border: Border.all(color: Colors.grey.shade300)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1, 1);
                                  });
                                },
                                icon: const Icon(Icons.chevron_left, size: 20),
                              ),
                              Text(
                                '${getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 1);
                                  });
                                },
                                icon: const Icon(Icons.chevron_right, size: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Min', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Sen', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Sel', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Rabu', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Kamis', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Jum', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                              Text('Sab', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                          const Divider(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: daysInMonth + firstDayOfWeek,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              if (index < firstDayOfWeek) {
                                return const SizedBox.shrink(); // Kotak kosong untuk penyesuaian hari
                              }
                              final day = index - firstDayOfWeek + 1;
                              final cellDate = DateTime(displayedMonth.year, displayedMonth.month, day);
                              
                              final isToday = cellDate.year == now.year &&
                                  cellDate.month == now.month &&
                                  cellDate.day == now.day;

                              final dateKey = '${cellDate.year}-${cellDate.month}-${cellDate.day}';
                              final hasDeadline = deadlineDateKeys.contains(dateKey);

                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isToday ? purple : (hasDeadline ? lightPurple : Colors.transparent),
                                  borderRadius: BorderRadius.circular(6),
                                  border: hasDeadline && !isToday ? Border.all(color: purple, width: 1) : null,
                                ),
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isToday ? Colors.white : (hasDeadline ? purple : Colors.black87),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // KOTAK JUDUL: [ TENGGAT TERDEKAT ]
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: shape(color: purple, radius: 12),
                      child: const Text(
                        '[ TENGGAT TERDEKAT ]',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DAFTAR PROYEK / DEADLINE DINAMIS SESUAI YANG DIINPUT
                    if (projectsWithDeadline.isNotEmpty)
                      ...projectsWithDeadline.map((project) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: shape(color: Colors.white, radius: 10, border: Border.all(color: Colors.grey.shade300)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project['title'] ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: purple),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${project['type']} | ${project['owner']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: shape(color: const Color(0xFFF0F0F0), radius: 8),
                                child: Text(
                                  project['deadline'] ?? '',
                                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: purple),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    else
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Belum ada tenggat waktu proyek yang ditambahkan.',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
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
                          return;
                        } else if (index == 2) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => EdukasiPage(username: widget.username)),
                          );
                        } else if (index == 3) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => CatatanPage(username: widget.username, projects: widget.projects)),
                          );
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