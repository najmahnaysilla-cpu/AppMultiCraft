import 'package:flutter/material.dart';

// [KODE DIALOG KELUAR]: Kotak pop-up konfirmasi saat user menekan tombol keluar/logout
class KeluarDialog extends StatelessWidget {
  const KeluarDialog({super.key});

  static const Color purple = Color(0xFF6757E8);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.exit_to_app, size: 40, color: purple),
            const SizedBox(height: 10),
            const Text('Yakin Ingin Keluar?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 5),
            const Text('Kamu akan keluar dari MultiCraft pastikan semua data sudah tersimpan.', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Colors.grey)),
            const SizedBox(height: 20),
            // Tombol "Ya, keluar" untuk kembali ke halaman awal/login
            SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Ya, keluar', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            // Tombol "Tidak" untuk menutup pop-up dan batal keluar
            SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE8E4FF), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                onPressed: () => Navigator.pop(context),
                child: const Text('Tidak', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}