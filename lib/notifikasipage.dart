import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  final String username;
  final List<Map<String, dynamic>> projects;

  const NotifikasiPage({
    super.key,
    required this.username,
    required this.projects,
  });

  static const Color purple = Color(0xFF6757E8);

  BoxDecoration shape({Color color = Colors.white, double radius = 12, Border? border}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER (Kotak biasa, tidak rounded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              decoration: const BoxDecoration(
                color: purple,
              ),
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
                  // Shape putih judul memanjang sesuai gambar referensi[span_2](start_span)[span_2](end_span)[span_3](start_span)[span_3](end_span)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: shape(color: Colors.white, radius: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_active, size: 16, color: purple),
                          SizedBox(width: 8),
                          Text(
                            'Pemberitahuan Notifikasi',
                            style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN NOTIFIKASI DINAMIS ATAU KOSONG
            Expanded(
              child: projects.isNotEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(16),
                      children: projects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: shape(color: Colors.white, radius: 12, border: Border.all(color: Colors.grey.shade200)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: shape(color: const Color(0xFFF0EEFC), radius: 8),
                                  child: const Icon(Icons.access_time_rounded, color: purple, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Proyek ${project['type']}',
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                                          ),
                                          Text(
                                            project['deadline']?.isNotEmpty == true ? 'Target: ${project['deadline']}' : 'Baru',
                                            style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Proyek "${project['title']}" sedang berjalan (Status: ${project['status']}).',
                                        style: const TextStyle(fontSize: 10, color: Colors.black54, height: 1.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Belum ada notifikasi atau proyek baru.',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}