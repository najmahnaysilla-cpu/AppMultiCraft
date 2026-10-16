import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'addsubtugas.dart'; // Menghubungkan ke file addsubtugas.dart

// =====================================================================
// HALAMAN DETAIL TAHAP: Tempat mencentang tugas, menulis catatan, & unggah berkas
// =====================================================================
class DetailTahapPage extends StatefulWidget {
  final String username;
  final String tahapNama;
  final String projectTitle;
  final List<Map<String, dynamic>> initialTasks;

  const DetailTahapPage({
    super.key,
    required this.username,
    required this.tahapNama,
    required this.projectTitle,
    required this.initialTasks,
  });

  @override
  State<DetailTahapPage> createState() => _DetailTahapPageState();
}

class _DetailTahapPageState extends State<DetailTahapPage> {
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);

  int selectedNav = 0;
  final List<Map<String, String>> navItems = const [
    {'name': 'dashboard', 'label': 'Beranda'},
    {'name': 'jadwal', 'label': 'Jadwal'},
    {'name': 'buku', 'label': 'Edukasi'},
    {'name': 'catatan', 'label': 'Catatan'},
    {'name': 'folder', 'label': 'Proyek'},
  ];

  late List<Map<String, dynamic>> tasks;
  final TextEditingController catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasks = List.from(widget.initialTasks);
  }

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

  Widget headerButton(String name, VoidCallback onTap) {
    return Container(
      width: 35, height: 35,
      decoration: shape(color: Colors.white, radius: 10),
      child: IconButton(padding: EdgeInsets.zero, onPressed: onTap, icon: assetIcon(name, size: 19)),
    );
  }

  // Membuka kotak dialog formulir dari file addsubtugas.dart (Nama kelas disesuaikan jadi AddTaskDialog)
  void showAddTaskDialog() async {
    final newTask = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const AddTaskDialog(),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = tasks.isEmpty ? 0 : tasks.where((t) => t['isDone'] == true).length / tasks.length;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, tasks);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // HEADER HALAMAN DETAIL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                decoration: const BoxDecoration(
                  color: purple,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35, height: 35,
                      decoration: shape(color: Colors.white, radius: 10),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context, tasks),
                        icon: const Icon(Icons.arrow_back, color: purple, size: 19),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: shape(color: Colors.white, radius: 20),
                        child: Text(
                          widget.tahapNama,
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

              // KONTEN DETAIL
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KARTU PROGRES TAHAP
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: shape(color: const Color(0xFF1E1E1E), radius: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Proyek : ${widget.projectTitle}',
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                  child: Text(widget.tahapNama, style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text('Progress Tahap Ini', style: TextStyle(color: Colors.white70, fontSize: 10)),
                            const SizedBox(height: 4),
                            Text('${(progress * 100).round()}% Selesai', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey.shade800,
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB8F56A)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Tombol "Tambah Tugas"
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: shape(color: Colors.black, radius: 8),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: showAddTaskDialog,
                            icon: const Icon(Icons.add, size: 14),
                            label: const Text('Tambah Tugas', style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ),

                      // Daftar Sub-Tugas (Checkbox)
                      if (tasks.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        const Text('[CENTANG DAFTAR TUGAS]', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                        const SizedBox(height: 6),
                        ...tasks.map((task) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: shape(color: Colors.white, radius: 8, border: Border.all(color: Colors.grey.shade300)),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: task['isDone'] ?? false,
                                    onChanged: (val) {
                                      setState(() {
                                        task['isDone'] = val ?? false;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      task['title'],
                                      style: const TextStyle(fontSize: 12, decoration: TextDecoration.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                    child: Text('PJ : ${task['pj']}', style: const TextStyle(fontSize: 9)),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(task['date'], style: const TextStyle(fontSize: 9, color: Colors.grey)),
                                ],
                              ),
                            )),
                      ],

                      const SizedBox(height: 15),
                      const Text('[CATATAN TEKNIS TAHAP]', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      const SizedBox(height: 6),
                      
                      // Kolom Catatan Teknis
                      Container(
                        decoration: shape(color: Colors.white, radius: 8),
                        child: TextField(
                          controller: catatanController,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 11),
                          decoration: InputDecoration(
                            hintText: 'Tuliskan catatan teknis tahap ini...',
                            hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black, width: 1)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black, width: 1)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.black, width: 1.5)),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                      const Text('[LAMPIRAN BERKAS/DOKUMEN]', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      const SizedBox(height: 6),
                      
                      // Kotak Unggah Berkas
                      CustomPaint(
                        painter: DashedRectPainter(color: Colors.black, strokeWidth: 1.2, gap: 4),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9FB),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [softShadow],
                          ),
                          child: const Center(
                            child: Text('+ Unggah Lampiran Baru', style: TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: shape(color: Colors.black, radius: 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => Navigator.pop(context, tasks),
                            child: const Text('Selesai', style: TextStyle(fontSize: 11)),
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
                            Navigator.pop(context, tasks);
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

// Alat bantu untuk menggambar garis putus-putus pada kotak unggah berkas
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 4.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ));

    Path dashPath = Path();
    for (var metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        double len = 5.0;
        dashPath.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        distance += len + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}