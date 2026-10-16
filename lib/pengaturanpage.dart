import 'package:flutter/material.dart';
import 'editprofilpage.dart';
import 'ubahsandipage.dart';
import 'keluardialog.dart';

// [KODE UTAMA]: Kelas untuk mengatur tampilan halaman Pengaturan aplikasi
class PengaturanPage extends StatefulWidget {
  final String username; // Variabel untuk menerima nama user yang sedang login

  const PengaturanPage({
    super.key,
    required this.username,
  });

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  // [WARNA TEMA]: Warna ungu utama aplikasi
  static const Color purple = Color(0xFF6757E8);

  // [STATUS DROPDOWN]: Menyimpan pilihan aktif untuk notifikasi dan kategori
  String notifStatus = 'Aktif';
  String defaultCategory = 'Semua Proyek';

  // [DESAIN KOTAK]: Rumus cepat untuk membuat sudut melengkung, warna, dan bayangan tipis
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

  // [PANGGIL GAMBAR ASET]: Fungsi untuk menampilkan ikon gambar dari folder komputer
  Widget assetIcon(String name, double size) {
    return Image.asset(
      'assets/images/$name.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          name == 'logo1' ? Icons.movie_creation_outlined : Icons.exit_to_app,
          size: size,
          color: name == 'logo1' ? purple : Colors.red,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membuat email otomatis berdasarkan nama user yang login
    final String email = '${widget.username.toLowerCase().replaceAll(' ', '')}@gmail.com';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // [BAGIAN HEADER ATAS]: Tombol panah kembali dan kotak judul pengaturan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              decoration: const BoxDecoration(color: purple),
              child: Row(
                children: [
                  // Tombol kembali ke halaman sebelumnya
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
                  // Kotak teks judul "Pengaturan"
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: shape(color: Colors.white, radius: 20),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings, size: 16, color: purple),
                          SizedBox(width: 8),
                          Text(
                            'Pengaturan',
                            style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // [BAGIAN ISI HALAMAN]: Daftar menu, profil, dropdown, info aplikasi, dan tombol keluar
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // [KARTU PROFIL]: Menampilkan informasi nama, email, dan tombol Edit Profil
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: shape(color: purple, radius: 12),
                    child: Row(
                      children: [
                        // Lingkaran ikon foto profil
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.person, color: purple, size: 30),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Teks nama user
                              Text(
                                widget.username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              const SizedBox(height: 2),
                              // Teks email user
                              Text(
                                email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70, fontSize: 10),
                              ),
                              const SizedBox(height: 8),
                              // Tombol Edit Profil
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    // Membuka halaman Edit Profil saat diklik
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditProfilPage(username: widget.username, email: email),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: shape(color: Colors.white, radius: 6),
                                    child: const Text(
                                      'Edit Profil',
                                      style: TextStyle(color: purple, fontSize: 9, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // [MENU 1]: Tombol Ubah Kata Sandi (Membuka halaman ganti password)
                  settingItem(
                    title: 'Ubah Kata Sandi',
                    trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UbahKataSandiPage()),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  // [MENU 2]: Kotak Dropdown Notifikasi Deadline (Aktif/Mati bisa diganti)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: shape(color: const Color(0xFFF7F6FC), radius: 10, border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Notifikasi Deadline',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        DropdownButton<String>(
                          value: notifStatus,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                          items: ['Aktif', 'Mati'].map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val, style: const TextStyle(fontSize: 11)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => notifStatus = newValue); // Mengubah pilihan status secara langsung
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // [MENU 3]: Kotak Dropdown Kategori Default (Bisa diganti pilihannya)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: shape(color: const Color(0xFFF7F6FC), radius: 10, border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Kategori Default',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        DropdownButton<String>(
                          value: defaultCategory,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                          items: ['Semua Proyek', 'Film', 'Podcast', 'Animasi'].map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val, style: const TextStyle(fontSize: 11)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => defaultCategory = newValue); // Mengubah pilihan kategori default secara langsung
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // [KOTAK INFO APLIKASI]: Menampilkan logo, nama aplikasi, dan keterangan versi
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: shape(color: const Color(0xFFF9F9FB), radius: 12, border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: shape(color: Colors.white, radius: 8),
                          child: assetIcon('logo1', 20),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('MultiCraft', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
                              SizedBox(height: 2),
                              Text('Kelola Pemberkasan & Edukasi: Film, Podcast & Animasi\nVersi 1.0.0', style: TextStyle(fontSize: 9, color: Colors.grey, height: 1.3)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // [TOMBOL KELUAR]: Membuka pop-up konfirmasi saat ingin keluar/logout
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const KeluarDialog(),
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          assetIcon('keluar', 18),
                          const SizedBox(width: 8),
                          const Text(
                            'Keluar',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ],
                      ),
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

  // [RUMUS BARIS MENU]: Alat bantu untuk merancang kotak menu agar seragam
  Widget settingItem({required String title, required Widget trailing, required VoidCallback onTap}) {
    return Container(
      decoration: shape(color: const Color(0xFFF7F6FC), radius: 10, border: Border.all(color: Colors.grey.shade200)),
      child: ListTile(
        onTap: onTap,
        dense: true,
        title: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
        trailing: trailing,
      ),
    );
  }
}