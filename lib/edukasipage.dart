import 'package:flutter/material.dart';
import 'tahapproduksi.dart';
import 'jadwalpage.dart';
import 'catatanpage.dart';
import 'folderpage.dart';
import 'panduanpage.dart';     
import 'notifikasipage.dart'; 
import 'pengaturanpage.dart'; 
import 'addprojectpage.dart'; 

// =====================================================================
// KELAS UTAMA: Mengatur tampilan beranda (dashboard) dan penyimpanan data
// =====================================================================
class EdukasiPage extends StatefulWidget {
  final String username; // Variabel untuk menerima nama user yang login dari halaman sebelumnya

  const EdukasiPage({
    super.key,
    required this.username,
  });

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  // [Warna Tema]: Warna ungu khas aplikasi
  static const Color purple = Color(0xFF6757E8);
  static const Color lightPurple = Color(0xFFE1DCFF);
  static const Color palePurple = Color(0xFFE8E4FF);

  // [Penyimpanan Global Statis]: Data proyek disimpan secara global agar tidak hilang saat berpindah halaman,
  // dan hanya akan dikosongkan jika nanti melakukan logout/keluar dari halaman pengaturan profil.
  static List<Map<String, dynamic>> globalProjects = [];

  // [Kontrol Pencarian]: Alat untuk mengambil teks yang diketik user di kotak search
  final TextEditingController searchController = TextEditingController();

  // [Penyaring Kategori]: Variabel untuk mengingat kategori apa yang sedang aktif dipilih user (default 'Semua')
  String selectedFilter = 'Semua';
  
  // [Pencarian Teks]: Menyimpan kata kunci huruf yang sedang diketik user untuk mencari judul proyek
  String searchText = '';
  
  // [Navigasi Bawah]: Angka penanda tombol menu mana yang sedang aktif disentuh (angka 0 = Beranda)
  int selectedNav = 0;

  // [Daftar Menu Navigasi Bawah]: Menyimpan nama file ikon saja (tanpa label teks di bawahnya)
  final List<String> navItems = const [
    'dashboard',
    'jadwal',
    'buku',
    'catatan',
    'folder',
  ];

  @override
  void dispose() {
    searchController.dispose(); // Membersihkan memori alat pencarian saat halaman ditutup
    super.dispose();
  }

  // [Lokasi Gambar]: Fungsi untuk merangkai jalur folder tempat gambar ikon PNG disimpan
  String assetPath(String name) => 'assets/images/$name.png';

  // [Efek Bayangan]: Rumus untuk memberikan efek timbul (shadow) pada kotak-kotak di aplikasi
  BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: 6,
        offset: const Offset(0, 3),
      );

  // [Desain Kotak]: Rumus cepat untuk membuat sudut kotak melengkung, warna background, dan bayangan
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

  // [Ikon Cadangan (Fallback)]: Ikon pengganti otomatis jika file gambar PNG di folder tidak sengaja tidak ketemu
  IconData fallbackIcon(String name) {
    switch (name) {
      case 'pengaturan': return Icons.settings_rounded;
      case 'bel': return Icons.notifications_rounded;
      case 'dashboard': return Icons.dashboard_rounded;
      case 'jadwal': return Icons.calendar_month_rounded;
      case 'buku': return Icons.menu_book_rounded;
      case 'catatan': return Icons.note_alt_outlined;
      case 'folder': return Icons.folder_outlined;
      case 'film': return Icons.movie_outlined;
      case 'podcast': return Icons.mic_none_rounded;
      case 'animasi': return Icons.animation_outlined;
      default: return Icons.image_outlined;
    }
  }

  // [Pemanggil Gambar Ikon]: Fungsi untuk menampilkan gambar PNG dari folder aset dengan pengaman error
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

  // [Pesan Pop-up Singkat]: Fungsi untuk menampilkan pemberitahuan kecil di bawah layar (SnackBar)
  void showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // [Rumus Penyaring Data (Filtering)]: Menyaring daftar proyek sesuai kategori tombol yang ditekan dan kata pencarian
  List<Map<String, dynamic>> get filteredProjects {
    return globalProjects.where((project) {
      final matchesFilter = selectedFilter == 'Semua' || project['type'] == selectedFilter;
      final matchesSearch = (project['title'] as String).toLowerCase().contains(searchText.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  // [Penghitung Kategori]: Menghitung total proyek berdasarkan masing-masing jenis untuk kotak Breakdown
  int get countFilm => globalProjects.where((p) => p['type'] == 'Film').length;
  int get countPodcast => globalProjects.where((p) => p['type'] == 'Podcast').length;
  int get countAnimasi => globalProjects.where((p) => p['type'] == 'Animasi').length;

  // [Penghitung Rata-rata Progress]: Rumus matematika untuk menghitung rata-rata total kemajuan semua proyek
  double get averageProgress {
    if (globalProjects.isEmpty) return 0;
    final total = globalProjects.fold<double>(0, (sum, p) => sum + (p['progress'] as num).toDouble());
    return total / globalProjects.length;
  }

  // [Tombol Header]: Desain tombol kecil di bagian atas (untuk Notifikasi dan Pengaturan)
  Widget headerButton(String name, VoidCallback onTap) {
    return Container(
      width: 35, height: 35,
      decoration: shape(color: Colors.white, radius: 10),
      child: IconButton(padding: EdgeInsets.zero, onPressed: onTap, icon: assetIcon(name, size: 19)),
    );
  }

  // [Fungsi Tambah Proyek]: Membuka form pop-up dari file sebelah, lalu memasukkan data hasil input ke keranjang globalProjects
  Future<void> showAddProjectDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AddProjectDialog(), // Memanggil file form pop-up
    );

    if (!mounted || result == null) return;

    setState(() {
      globalProjects.add({
        'title': result['title'] as String,
        'type': result['type'] as String,
        'owner': result['owner'] as String,
        'status': 'Pra Produksi',
        'progress': 0.0,
        'tasks': 0,
        'deadline': result['deadline'] as String? ?? '',
      });
      selectedFilter = 'Semua';
      searchText = '';
      searchController.clear();
    });

    showMessage('Proyek berhasil ditambahkan.');
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredProjects;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // =================================================================
            // [BAGIAN ATAS]: Header Profil, Nama User, dan Tombol Ikon Atas
            // =================================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
              decoration: const BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              ),
              child: Row(
                children: [
                  // Kotak Foto Profil Bulat
                  Container(
                    width: 42, height: 42, clipBehavior: Clip.antiAlias,
                    decoration: shape(color: Colors.white, radius: 21),
                    child: const Icon(Icons.person, color: purple, size: 29),
                  ),
                  const SizedBox(width: 10),
                  // Teks Sambutan dan Nama User yang login
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Selamat Datang!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 3),
                        Text(widget.username, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // Tombol Lonceng (Menuju Halaman Notifikasi)
                  headerButton('bel', () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotifikasiPage(username: widget.username, projects: globalProjects)))),
                  const SizedBox(width: 8),
                  // Tombol Pengaturan (Menuju Halaman Pengaturan)
                  headerButton('pengaturan', () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => PengaturanPage(username: widget.username)));
                  }),
                ],
              ),
            ),

            // =================================================================
            // [BAGIAN ISI (SCROLLABLE)]: Search Bar, Statistik, Filter, dan Kartu Proyek
            // =================================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // [Kotak Pencarian & Tombol Plus (+)]
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            decoration: shape(color: const Color(0xFFF5F4FA), radius: 22, border: Border.all(color: const Color(0xFFE7E3F7))),
                            child: Center(
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) => setState(() => searchText = value), // Mencari judul proyek otomatis saat diketik
                                style: const TextStyle(fontSize: 12),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: 'Telusuri proyek...',
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                  prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 9),
                        // Tombol Tambah (+) untuk memunculkan form pop-up
                        InkWell(
                          onTap: showAddProjectDialog,
                          borderRadius: BorderRadius.circular(11),
                          child: Container(
                            width: 42, height: 42,
                            decoration: shape(color: purple, radius: 11),
                            child: const Icon(Icons.add, color: Colors.white, size: 25),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 17),

                    // [3 Kotak Informasi Statistik di Atas]
                    Row(
                      children: [
                        Expanded(child: statCard('Total Proyek', '${globalProjects.length} Proyek')),
                        const SizedBox(width: 7),
                        Expanded(child: breakdownCard()), // Kotak tengah rincian kategori (Film, Podcast, Animasi)
                        const SizedBox(width: 7),
                        Expanded(child: statCard('Total AVG', '${(averageProgress * 100).round()}%')),
                      ],
                    ),

                    const SizedBox(height: 17),

                    // [Tombol Filter Kategori Berikon (Semua, Film, Podcast, Animasi)]
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F6FC),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: const Color(0xFFE7E3F7), width: 1.2),
                        boxShadow: [softShadow],
                      ),
                      child: Row(
                        children: ['Semua', 'Film', 'Podcast', 'Animasi'].map((filter) {
                          final active = selectedFilter == filter;
                          final String? filterAsset = switch (filter) {
                            'Film' => 'film',
                            'Podcast' => 'podcast',
                            'Animasi' => 'animasi',
                            _ => null,
                          };

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: InkWell(
                                onTap: () => setState(() => selectedFilter = filter), // Mengubah filter aktif saat diklik
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: active ? purple : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4, offset: const Offset(0, 2))],
                                    border: active ? null : Border.all(color: const Color(0xFFDCD6F7), width: 1.2),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (filterAsset != null) assetIcon(filterAsset, size: 14, color: active ? Colors.white : Colors.black87),
                                        if (filterAsset != null) const SizedBox(width: 3),
                                        Text(
                                          filter,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: active ? Colors.white : Colors.black87,
                                            fontWeight: active ? FontWeight.bold : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 13),
                    Container(height: 2, width: double.infinity, decoration: BoxDecoration(color: purple, boxShadow: [softShadow])),
                    const SizedBox(height: 12),

                    // [Daftar Kartu Proyek yang Tampil di Layar]
                    if (filtered.isNotEmpty)
                      ...filtered.map((project) => Padding(padding: const EdgeInsets.only(bottom: 12), child: projectCard(project)))
                    else if (globalProjects.isNotEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text('Proyek tidak ditemukan.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // =================================================================
            // [BAGIAN BAWAH]: Menu Navigasi (Icon Murni Berubah Putih Terang Saat Aktif Tanpa Shape)
            // =================================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: shape(color: purple, radius: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(navItems.length, (index) {
                    final itemName = navItems[index];
                    final active = selectedNav == index;
                    
                    // ICON AKTIF = PUTIH TERANG MURNI, TIDAK AKTIF = UNGU MUDA
                    final Color iconColor = active ? Colors.white : lightPurple;

                    return InkWell(
                      onTap: () {
                        setState(() => selectedNav = index);
                        if (index == 0) {
                          return; // Berada di halaman utama (Beranda)
                        } else if (index == 1) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => JadwalPage(username: widget.username, projects: globalProjects)));
                        } else if (index == 2) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PanduanPage(username: widget.username)));
                        } else if (index == 3) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CatatanPage(username: widget.username, projects: globalProjects)));
                        } else if (index == 4) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => FolderPage(username: widget.username, projects: globalProjects)));
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: assetIcon(
                          itemName, 
                          size: 24, 
                          color: iconColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // [Template Kotak Statistik Pinggir]
  Widget statCard(String title, String value) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: shape(color: purple, radius: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(height: 1, color: Colors.white24),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(value, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // [Template Kotak Breakdown Tengah]
  Widget breakdownCard() {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: shape(color: purple, radius: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Breakdown', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(height: 1, color: Colors.white24),
          Expanded(
            child: Row(
              children: [
                breakdownItem('film', countFilm),
                breakdownItem('podcast', countPodcast),
                breakdownItem('animasi', countAnimasi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget breakdownItem(String name, int count) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(right: name == 'animasi' ? BorderSide.none : const BorderSide(color: Colors.white, width: 1)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              assetIcon(name, size: 14, color: Colors.white),
              const SizedBox(width: 3),
              Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // [Template Kartu Proyek]: Menggunakan aset gambar 'film', 'podcast', dan 'animasi' di dekat teks PJ
  Widget projectCard(Map<String, dynamic> project) {
    final type = project['type'] as String;
    final progress = (project['progress'] as num).toDouble();
    final totalTasks = project['tasks'] as int;
    
    // Menyesuaikan ikon aset berdasarkan kategori tipe proyek
    final categoryAsset = type == 'Film' ? 'film' : type == 'Podcast' ? 'podcast' : 'animasi';

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TahapanProduksiPage(
              username: widget.username,
              productionType: type,
              projectTitle: project['title'] as String,
              projectOwner: project['owner'] as String,
              projectDeadline: project['deadline'] as String? ?? '',
            ),
          ),
        );

        // Memperbarui data kemajuan proyek jika ada perubahan di halaman rincian
        if (result != null && result is Map<String, dynamic>) {
          setState(() {
            project['tasks'] = result['tasksCount'] ?? project['tasks'];
            project['progress'] = result['progress'] ?? project['progress'];
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: shape(color: purple, radius: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: shape(color: Colors.white, radius: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      assetIcon(categoryAsset, size: 16, color: purple),
                      const SizedBox(width: 5),
                      Text(type, style: const TextStyle(color: purple, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(project['owner'] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: shape(color: Colors.white, radius: 5),
                  child: Text(project['status'] as String, style: const TextStyle(color: purple, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(project['title'] as String, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            if ((project['deadline'] as String? ?? '').isNotEmpty) ...[
              const SizedBox(height: 3),
              Text('Target: ${project['deadline']}', style: const TextStyle(color: Colors.white70, fontSize: 9)),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Progress Total', style: TextStyle(color: Colors.white, fontSize: 9)),
                const Spacer(),
                Text('${(progress * 100).round()}%', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(value: progress, minHeight: 5, backgroundColor: Colors.white24, valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB8F56A))),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white70, size: 12),
                const SizedBox(width: 4),
                Text('$totalTasks Sub Tugas', style: const TextStyle(color: Colors.white70, fontSize: 9)),
                const Spacer(),
                const Icon(Icons.open_in_new, color: Colors.white, size: 11),
                const SizedBox(width: 3),
                const Text('Inspeksi', style: TextStyle(color: Colors.white, fontSize: 9)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}