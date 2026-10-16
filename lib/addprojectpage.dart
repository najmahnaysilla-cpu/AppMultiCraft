import 'package:flutter/material.dart';

// ======================================================
// FORM TAMBAH PROYEK (ADD PROJECT DIALOG) ASLI SESUAI TAMPILAN
// ======================================================
class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  static const Color purple = Color(0xFF6757E8);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String type = 'Film';
  String? titleError;

  @override
  void dispose() {
    titleController.dispose();
    ownerController.dispose();
    dateController.dispose();
    super.dispose();
  }

  BoxDecoration inputDecoration() {
    return BoxDecoration(
      color: const Color(0xFFF5F4FA),
      borderRadius: BorderRadius.circular(9),
    );
  }

  Widget inputField(
    TextEditingController controller,
    String hint,
  ) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 11),
      onChanged: controller == titleController
          ? (_) {
              if (titleError != null) {
                setState(() => titleError = null);
              }
            }
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
        errorText: controller == titleController ? titleError : null,
        filled: true,
        fillColor: const Color(0xFFF5F4FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget actionButton(
    String label,
    Color background,
    Color foreground,
    VoidCallback onTap,
  ) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickDeadline() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: purple),
          ),
          child: child!,
        );
      },
    );

    if (!mounted || date == null) return;

    setState(() {
      dateController.text = '${date.day}/${date.month}/${date.year}';
    });
  }

  void saveProject() {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      setState(() => titleError = 'Judul proyek wajib diisi.');
      return;
    }

    final owner = ownerController.text.trim();

    Navigator.of(context).pop(<String, dynamic>{
      'title': title,
      'type': type,
      'owner': owner.isEmpty ? 'PJ: Belum diisi' : owner,
      'deadline': dateController.text,
    });
  }

  Widget categoryIcon(String category) {
    final fallback = category == 'Film'
        ? Icons.movie_outlined
        : category == 'Podcast'
            ? Icons.mic_none_rounded
            : Icons.animation_outlined;

    return Image.asset(
      'assets/images/${category.toLowerCase()}.png',
      width: 19,
      height: 19,
      fit: BoxFit.contain,
      color: Colors.black,
      colorBlendMode: BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          fallback,
          size: 19,
          color: Colors.black,
        );
      },
    );
  }

  Widget categoryOption(String category) {
    return Row(
      children: [
        categoryIcon(category),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            category,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Film', 'Podcast', 'Animasi'];

    return Dialog(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '[ + BUAT PROYEK BARU ]',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, size: 18),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 8),

            const Text(
              'Judul Proyek*',
              style: TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 5),
            inputField(
              titleController,
              'Contoh : Film Pendek "Masih Disini"',
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kategori Media*',
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: inputDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: type,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: Colors.black,
                            ),
                            selectedItemBuilder: (context) {
                              return categories.map((category) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: categoryOption(category),
                                );
                              }).toList();
                            },
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: categoryOption(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => type = value);
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
                      const Text(
                        'Penanggung Jawab (PJ)',
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 42,
                        child: inputField(ownerController, 'Hanni (Director)'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'Target / Deadline Selesai',
              style: TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 42,
              child: TextField(
                controller: dateController,
                readOnly: true,
                onTap: pickDeadline,
                style: const TextStyle(fontSize: 11),
                decoration: InputDecoration(
                  hintText: 'Contoh : 12 September 2026',
                  hintStyle: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F4FA),
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    size: 17,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: actionButton(
                    'Batal',
                    const Color(0xFFF0F0F0),
                    Colors.black87,
                    () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: actionButton(
                    '+ Simpan Proyek',
                    const Color(0xFF1E1E2C), // Warna tombol simpan gelap sesuai gambar
                    Colors.white,
                    saveProject,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}