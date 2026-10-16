import 'package:flutter/material.dart';

// [KODE HALAMAN EDIT PROFIL]: Tempat user mengubah nama, email, nomor telepon (dikosongkan), bio, dan foto profil
class EditProfilPage extends StatefulWidget {
  final String username;
  final String email;

  const EditProfilPage({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  static const Color purple = Color(0xFF6757E8);
  late TextEditingController nameController;
  late TextEditingController emailController;
  
  // [KOTAK TELEPON KOSONG]: Sengaja dikosongkan agar user bisa mengetik nomor sendiri
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String selectedPhotoOption = ''; // Menyimpan status pilihan menu foto

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  // [RUMUS KOTAK]: Membuat sudut melengkung dan bayangan
  BoxDecoration shape({Color color = Colors.white, double radius = 12, Border? border}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5, offset: const Offset(0, 2)),
      ],
    );
  }

  // [DIALOG PILIH FOTO]: Memunculkan pilihan cara mengganti foto profil
  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '[Pilih Foto Profil]',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    optionButton('Ambil Foto', selectedPhotoOption == 'Ambil Foto', () {
                      setDialogState(() => selectedPhotoOption = 'Ambil Foto');
                    }),
                    const SizedBox(height: 8),
                    optionButton('Dari Perangkat', selectedPhotoOption == 'Dari Perangkat', () {
                      setDialogState(() => selectedPhotoOption == 'Dari Perangkat');
                    }),
                    const SizedBox(height: 8),
                    optionButton('Hapus Foto', selectedPhotoOption == 'Hapus Foto', () {
                      setDialogState(() => selectedPhotoOption = 'Hapus Foto');
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // [TOMBOL OPSI FOTO]: Tombol pilihan dengan efek warna hijau saat dipilih
  Widget optionButton(String text, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC8E6C9) : const Color(0xFFF5F4FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.green.shade900 : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // [HEADER EDIT PROFIL]: Tombol kembali dan judul halaman
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              decoration: const BoxDecoration(color: purple),
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: shape(color: Colors.white, radius: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, size: 16, color: purple),
                          SizedBox(width: 8),
                          Text('Edit Profil', style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // [KOTAK INPUT FORMULIR]: Kolom teks untuk mengubah data diri
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Kartu foto profil yang bisa diklik
                  GestureDetector(
                    onTap: showPhotoOptions,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: shape(color: purple, radius: 12),
                      child: const Row(
                        children: [
                          CircleAvatar(radius: 22, backgroundColor: Colors.white, child: Icon(Icons.person, color: purple)),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Foto Profil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              Text('Pilih foto atau gunakan foto saat ini', style: TextStyle(color: Colors.white70, fontSize: 9)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Nama Lengkap', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(controller: nameController, style: const TextStyle(fontSize: 11), decoration: inputDec()),
                  const SizedBox(height: 12),
                  const Text('Email', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(controller: emailController, style: const TextStyle(fontSize: 11), decoration: inputDec()),
                  const SizedBox(height: 12),
                  const Text('Nomor Telepon', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(controller: phoneController, style: const TextStyle(fontSize: 11), decoration: inputDec(hint: 'Masukkan nomor telepon...')),
                  const SizedBox(height: 12),
                  const Text('Bio', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(controller: bioController, style: const TextStyle(fontSize: 11), decoration: inputDec(hint: '(Opsional)')),
                  const SizedBox(height: 24),
                  // Tombol simpan perubahan
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // [DESAIN INPUT TEKS]: Rumus dekorasi kotak teks formulir
  InputDecoration inputDec({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F4FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
    );
  }
}