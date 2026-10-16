import 'package:flutter/material.dart';

// =====================================================================
// KELAS TAHAP CARD: Komponen kotak untuk menampilkan status tiap tahapan
// =====================================================================
class TahapCardWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tasks;
  final VoidCallback onTapDetail;
  final BoxDecoration Function({Color color, double radius, Border? border}) shape;
  final Color purple;

  const TahapCardWidget({
    super.key,
    required this.title,
    required this.tasks,
    required this.onTapDetail,
    required this.shape,
    required this.purple,
  });

  @override
  Widget build(BuildContext context) {
    int totalTasks = tasks.length;

    // Jika tugas masih kosong, tampilkan kotak polos dengan panah ke kanan
    if (totalTasks == 0) {
      return InkWell(
        onTap: onTapDetail,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: shape(
            color: const Color(0xFFEFEFEF),
            radius: 8,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Jika sudah ada tugas, hitung persentase dan tampilkan progress bar
    int doneTasks = tasks.where((t) => t['isDone'] == true).length;
    int percent = ((doneTasks / totalTasks) * 100).round();
    String firstTaskTitle = tasks.first['title'];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: shape(color: const Color(0xFFEFEFEF), radius: 10, border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              // Kotak kecil menampilkan persentase selesai
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$percent%',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Judul tugas pertama
          Text(
            firstTaskTitle,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          // Garis indikator kemajuan (progress bar)
          LinearProgressIndicator(
            value: totalTasks == 0 ? 0 : doneTasks / totalTasks,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(percent > 0 ? const Color(0xFF4CAF50) : Colors.grey.shade400),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalTasks Tugas',
                style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              // Tombol teks untuk membuka halaman detail
              GestureDetector(
                onTap: onTapDetail,
                child: const Text(
                  'Detail..',
                  style: TextStyle(fontSize: 10, color: Color(0xFF6757E8), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}