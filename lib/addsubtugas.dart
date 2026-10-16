import 'package:flutter/material.dart';

// =====================================================================
// KOTAK FORM POP-UP: Menampilkan dialog input sub-tugas baru
// =====================================================================
class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController pjController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  
  final ValueNotifier<bool> isDateFocused = ValueNotifier<bool>(false);

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
    isDateFocused.dispose();
    super.dispose();
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
              onTap: () => isDateFocused.value = true,
              onChanged: (_) => isDateFocused.value = true,
              decoration: const InputDecoration(
                hintText: 'Tenggat Waktu',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<bool>(
            valueListenable: isDateFocused,
            builder: (context, isFocused, child) {
              return GestureDetector(
                onTap: () {
                  if (taskController.text.isNotEmpty) {
                    Navigator.pop(context, {
                      'title': taskController.text,
                      'pj': pjController.text.isEmpty ? 'Belum diisi' : pjController.text,
                      'date': dateController.text.isEmpty ? '-' : dateController.text,
                      'isDone': false,
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: shape(
                    color: isFocused ? Colors.black : const Color(0xFFE2E2E2),
                    radius: 8,
                  ),
                  child: Text(
                    'Buat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isFocused ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}