import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notification_helper.dart';

class AddProjectPage extends StatefulWidget {
  final String username;

  const AddProjectPage({
    super.key,
    required this.username,
  });

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  static const Color purple = Color(0xFF6757E8);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  String selectedType = 'Film';
  final List<String> projectTypes = ['Film', 'Podcast', 'Animasi'];
  
  final Map<String, String> projectIcons = {
    'Film': 'assets/images/film.png',
    'Podcast': 'assets/images/podcast.png',
    'Animasi': 'assets/images/animasi.png',
  };

  bool isLoading = false;

  void showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : purple,
        ),
      );
  }

  Future<void> _submitProject() async {
    final title = titleController.text.trim();
    final owner = ownerController.text.trim();
    final deadline = deadlineController.text.trim();

    if (title.isEmpty || owner.isEmpty || deadline.isEmpty) {
      showMessage('Semua kolom wajib diisi!', isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.9/multicraft/api/add_project.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'title': title,
          'type': selectedType,
          'owner': owner,
          'deadline': deadline,
          'username': widget.username,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        await NotificationService.showInstantNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: 'Proyek Baru Ditambahkan!',
          body: 'Proyek "$title" berhasil dibuat. Ayo selesaikan tepat waktu!',
        );

        showMessage('Proyek berhasil disimpan ke database!');
        if (!mounted) return;
        Navigator.pop(context, true); 
      } else {
        showMessage(data['message'] ?? 'Gagal menyimpan proyek.', isError: true);
      }
    } catch (e) {
      showMessage('Koneksi ke server gagal. Pastikan XAMPP aktif.', isError: true);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER POPUP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '[ + BUAT PROYEK BARU ]',
                    style: TextStyle(
                      color: purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 18, color: Colors.black54),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 1),

              // JUDUL PROYEK
              const Text('Judul Proyek*', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
              const SizedBox(height: 4),
              SizedBox(
                height: 38,
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    hintText: "Contoh : Film Pendek 'Masih Disini'",
                    hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // KATEGORI MEDIA & PENANGGUNG JAWAB (SEJAJAR)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Kategori Media*', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
                        const SizedBox(height: 4),
                        Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedType,
                              isExpanded: true,
                              items: projectTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        projectIcons[type]!,
                                        width: 14,
                                        height: 14,
                                        color: Colors.black87,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(type, style: const TextStyle(fontSize: 10, color: Colors.black87)),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() => selectedType = newValue);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Penanggung Jawab (PJ)*', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 38,
                          child: TextField(
                            controller: ownerController,
                            style: const TextStyle(fontSize: 11),
                            decoration: InputDecoration(
                              hintText: 'Hanni (Director)',
                              hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // TARGET DEADLINE
              const Text('Target / Deadline Selesai*', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87)),
              const SizedBox(height: 4),
              SizedBox(
                height: 38,
                child: TextField(
                  controller: deadlineController,
                  style: const TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    hintText: 'Contoh : 12 September 2026',
                    hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // TOMBOL BATAL & SIMPAN
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: isLoading ? null : _submitProject,
                        child: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text(
                                '+ Simpan Proyek',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}