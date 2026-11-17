import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTaskDialog extends StatefulWidget {
  final String projectTitle; // Menerima judul proyek induknya

  const AddTaskDialog({
    super.key,
    required this.projectTitle,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController pjController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  
  bool isLoading = false;

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

  @override
  void dispose() {
    taskController.dispose();
    pjController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    final taskTitle = taskController.text.trim();
    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tuliskan sub tugas terlebih dahulu.')),
      );
      return;
    }

    final pj = pjController.text.trim();
    final deadline = dateController.text.trim();

    setState(() {
      isLoading = true;
    });

    try {
      // Mengirim sub-tugas ke backend PHP menggunakan IP lokal
      final response = await http.post(
        Uri.parse('http://192.168.1.9/multicraft/api/add_subtugas.php'),
        body: {
          'project_title': widget.projectTitle,
          'task_title': taskTitle,
          'pj': pj.isEmpty ? 'Belum diisi' : pj,
          'deadline': deadline.isEmpty ? '-' : deadline,
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          // Tutup dialog dan kirim data ke halaman sebelumnya
          Navigator.pop(context, {
            'title': taskTitle,
            'pj': pj.isEmpty ? 'Belum diisi' : pj,
            'date': deadline.isEmpty ? '-' : deadline,
            'isDone': false,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Gagal menyimpan sub-tugas.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan pada server.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal terhubung ke server: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: shape(color: const Color(0xFFF2F2F2), radius: 8),
            child: TextField(
              controller: taskController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'Tuliskan Sub Tugas',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: shape(color: const Color(0xFFF2F2F2), radius: 8),
            child: TextField(
              controller: pjController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'Tuliskan Posisi Penanggung Jawab',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: shape(color: const Color(0xFFF2F2F2), radius: 8),
            child: TextField(
              controller: dateController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'Tenggat Waktu',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: isLoading ? null : _saveTask,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: shape(
                color: Colors.black,
                radius: 8,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Buat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}