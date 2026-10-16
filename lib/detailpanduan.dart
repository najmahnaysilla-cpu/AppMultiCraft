import 'package:flutter/material.dart';
import 'notifikasipage.dart';
import 'pengaturanpage.dart';
import 'ujipemahamanpage.dart';
import 'panduandata.dart';

// =====================================================================
// KELAS UTAMA: DetailPanduanPage
// Berfungsi untuk menampilkan halaman detail panduan berdasarkan kategori 
// yang dipilih (Film, Podcast, atau Animasi).
// =====================================================================
class DetailPanduanPage extends StatefulWidget {
  final String username;
  final String categoryTitle;

  const DetailPanduanPage({
    super.key,
    required this.username,
    required this.categoryTitle,
  });

  @override
  State<DetailPanduanPage> createState() => _DetailPanduanPageState();
}

class _DetailPanduanPageState extends State<DetailPanduanPage> {
  // Definisi warna utama aplikasi yang konsisten (Ungu)
  static const Color purple = Color(0xFF6757E8);
  static const Color cardBgColor = Color(0xFFEFEFF7);

  // Fungsi helper untuk memanggil file gambar/ikon dari folder assets
  String assetPath(String name) => 'assets/images/$name.png';

  // Efek bayangan lembut (soft shadow) untuk mempercantik tampilan kartu
  BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 4,
        offset: const Offset(0, 2),
      );

  // Efek bayangan teks (shadow) agar menyerupai referensi desain Figma
  List<Shadow> get textShadow => [
        Shadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 2),
          blurRadius: 3,
        ),
      ];

  // Helper dekorasi container (border radius, warna, dan shadow)
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

  // Widget helper untuk merender ikon gambar dari assets secara aman (dengan fallback icon)
  Widget assetIcon(String name, {double size = 20, Color? color}) {
    return Image.asset(
      assetPath(name),
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
      colorBlendMode: color == null ? null : BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: size, color: color ?? purple),
    );
  }

  // Tombol aksi di bagian header atas (Notifikasi & Pengaturan)
  Widget headerButton(String name, VoidCallback onTap) {
    return Container(
      width: 35,
      height: 35,
      decoration: shape(color: Colors.white, radius: 10),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: assetIcon(name, size: 19),
      ),
    );
  }

  // Fungsi universal untuk menampilkan pop-up dialog materi secara interaktif
  void _showPopupDialog(String title, Widget contentWidget) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 580),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: shape(color: purple, radius: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul pop-up di bagian atas lengkap dengan efek bayangan teks
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      shadows: textShadow,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Area konten pop-up yang dapat digulir (scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: contentWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah kategori saat ini adalah "Animasi" untuk penyesuaian tata letak khusus
    final isAnimasi = widget.categoryTitle.toLowerCase() == 'animasi';
    final cat = widget.categoryTitle.toLowerCase();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===================================================================
            // BAGIAN HEADER ATAS: Menampilkan profil pengguna, nama, serta tombol notifikasi & pengaturan
            // ===================================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
              decoration: BoxDecoration(
                color: purple,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [softShadow],
              ),
              child: Row(
                children: [
                  // Avatar Profil Pengguna
                  Container(
                    width: 42,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: shape(color: Colors.white, radius: 21),
                    child: const Icon(Icons.person, color: purple, size: 29),
                  ),
                  const SizedBox(width: 10),
                  // Nama Pengguna
                  Expanded(
                    child: Text(
                      widget.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Tombol Notifikasi (Bel)
                  headerButton('bel', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotifikasiPage(
                          username: widget.username,
                          projects: const [],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  // Tombol Pengaturan
                  headerButton('pengaturan', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PengaturanPage(
                          username: widget.username,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // ===================================================================
            // BAGIAN KONTEN UTAMA: Daftar menu panduan dan navigasi
            // ===================================================================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Baris Navigasi Kembali & Keterangan Kategori
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.arrow_back, color: purple, size: 22),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Panduan Produksi ${widget.categoryTitle}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: purple,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Pelajari dasar produksi ${widget.categoryTitle.toLowerCase()} dari awal hingga akhir.',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        // ===================================================
                        // TATA LETAK KHUSUS KATEGORI ANIMASI (5 Shape Menu)
                        // ===================================================
                        if (isAnimasi) ...[
                          // Baris 1: Perbedaan 2D dan 3D & Tahapan Produksi
                          Row(
                            children: [
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Perbedaan 2D dan 3D',
                                  subtitle: 'Mengenal perbedaan visual animasi 2D dan 3D.',
                                  // Menggunakan kustom ikon berupa teks "2D/3D" di dalam kotak ungu
                                  customIconWidget: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: purple,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '2D/3D',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  onTap: () {
                                    // Pop-up Perbedaan 2D & 3D dengan kartu bergambar aset 2d dan 3d
                                    _showPopupDialog(
                                      'Panduan Produksi Animasi',
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: shape(color: const Color(0xFF7B70EE), radius: 12),
                                            child: Column(
                                              children: [
                                                Text('Animasi 2D', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, shadows: textShadow)),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  height: 110,
                                                  width: double.infinity,
                                                  child: Image.asset(assetPath('2d'), fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Center(child: Text('2d.png tidak ada', style: TextStyle(fontSize: 9, color: Colors.white)))),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'Menggunakan gambar dua dimensi dengan panjang dan lebar. Gerakan dibuat melalui rangkaian gambar atau teknik rigging 2D.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.3),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: shape(color: const Color(0xFF7B70EE), radius: 12),
                                            child: Column(
                                              children: [
                                                Text('Animasi 3D', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, shadows: textShadow)),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  height: 110,
                                                  width: double.infinity,
                                                  child: Image.asset(assetPath('3d'), fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Center(child: Text('3d.png tidak ada', style: TextStyle(fontSize: 9, color: Colors.white)))),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  'Menggunakan objek tiga dimensi yang memiliki panjang, lebar, dan kedalaman. Karakter dapat dibuat melalui modeling, rigging, dan animasi 3D.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.3),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Tahapan Produksi',
                                  subtitle: 'Pra-Produksi, Produksi dan Pasca-Produksi.',
                                  assetName: 'catatan',
                                  onTap: () {
                                    _showPopupDialog('Tahapan Produksi', PanduanData.getTahapanContent(widget.categoryTitle));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Baris 2: Peran Kru & Peralatan Produksi
                          Row(
                            children: [
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Peran Kru',
                                  subtitle: 'Tugas dan tanggung jawab setiap kru.',
                                  assetName: 'grup',
                                  onTap: () {
                                    // Pop-up Peran Kru Animasi (Menggunakan PageView 4 Slide)
                                    Widget crewContent = StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setStateDialog) {
                                        final PageController pageController = PageController();
                                        int currentPage = 0;
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 380,
                                              child: PageView(
                                                controller: pageController,
                                                onPageChanged: (index) {
                                                  setStateDialog(() { currentPage = index; });
                                                },
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(child: Text('Peran Kru Animasi 2D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow))),
                                                        const SizedBox(height: 12),
                                                        PanduanData.buildCrewItem('user', 'Produser', 'Bertanggung jawab atas perencanaan, anggaran, dan keseluruhan produksi.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('clapper', 'Sutradara', 'Mengarahkan cerita dan visual animasi.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('catatan', 'Penulis Skenario', 'Menulis cerita dan dialog.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('storyboard', 'Storyboard Artist', 'Menggambarkan urutan adegan.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('pentol', '2D Artist', 'Menggambar karakter, latar, dan aset 2D.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('background', 'Background Artist', 'Membuat latar belakang setiap adegan.', purple, shape, assetIcon),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(child: Text('Peran Kru Animasi 2D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow))),
                                                        const SizedBox(height: 12),
                                                        PanduanData.buildCrewItem('animasi', 'Animator', 'Membuat gerakan melalui gambar atau rigging 2D.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('blank', 'Clean-up Artist', 'Merapikan garis dan gambar animasi.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('lukis', 'Colorist', 'Memberikan warna pada karakter dan adegan.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('monitor1', 'Editor Video', 'Menyusun animasi dan audio.', purple, shape, assetIcon),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(child: Text('Peran Kru Animasi 3D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow))),
                                                        const SizedBox(height: 12),
                                                        PanduanData.buildCrewItem('user', 'Produser', 'Bertanggung jawab atas perencanaan, anggaran, dan keseluruhan produksi.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('clapper', 'Sutradara', 'Mengarahkan cerita dan visual animasi.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('catatan', 'Penulis Skenario', 'Menulis cerita dan dialog.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('storyboard', 'Storyboard Artist', 'Menggambarkan urutan adegan.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('kubus', '3D Modeller', 'Membuat karakter dan objek 3D.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('lukis', 'Texture Artist', 'Memberikan warna dan tekstur pada model 3D.', purple, shape, assetIcon),
                                                      ],
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(child: Text('Peran Kru Animasi 3D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow))),
                                                        const SizedBox(height: 12),
                                                        PanduanData.buildCrewItem('rigger', 'Rigger', 'Membuat tulang dan kontrol karakter.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('animasi', 'Animator', 'Membuat gerakan karakter dan objek 3D.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('ide', 'Lighting Artist', 'Mengatur pencahayaan adegan 3D.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('effect', 'VFX Artist', 'Membuat efek visual seperti partikel dan ledakan.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('render', 'Rendering Artist', 'Mengatur proses rendering dan kualitas hasil gambar.', purple, shape, assetIcon),
                                                        PanduanData.buildCrewItem('monitor1', 'Editor Video', 'Menyusun hasil render dan audio.', purple, shape, assetIcon),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 32, height: 32,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      if (currentPage > 0) {
                                                        pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      } else {
                                                        pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.arrow_back, color: purple, size: 16),
                                                  ),
                                                ),
                                                Text('Slide ${currentPage + 1} dari 4', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, shadows: textShadow)),
                                                Container(
                                                  width: 32, height: 32,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      if (currentPage < 3) {
                                                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      } else {
                                                        pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.arrow_forward, color: purple, size: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    _showPopupDialog('Peran Kru', crewContent);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Peralatan Produksi',
                                  subtitle: 'Alat dan software yang dibutuhkan',
                                  assetName: 'film',
                                  onTap: () {
                                    // Pop-up Peralatan Animasi (2 Slide: 2D & 3D)
                                    Widget peralatanContent = StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setStateDialog) {
                                        final PageController pageController = PageController();
                                        int currentPage = 0;
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 380,
                                              child: PageView(
                                                controller: pageController,
                                                onPageChanged: (index) {
                                                  setStateDialog(() { currentPage = index; });
                                                },
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text('Peralatan Produksi Animasi 2D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow)),
                                                      const SizedBox(height: 12),
                                                      Row(children: [
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'pencil', title: 'Alat Menggambar', items: '1. Stylus Pen\n2. Pensil\n3. Kertas', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                        const SizedBox(width: 10),
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'monitor', title: 'Perangkat Digital', items: '1. Laptop\n2. Pen Tablet', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                      ]),
                                                      const SizedBox(height: 10),
                                                      Row(children: [
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'scanner', title: 'Digitalisasi Gambar', items: 'Scanner', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                        const SizedBox(width: 10),
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'monitor1', title: 'Software Animasi', items: '1. Clip Studio Paint\n2. Ibis Paint', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                      ]),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text('Peralatan Produksi Animasi 3D', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow)),
                                                      const SizedBox(height: 12),
                                                      Row(children: [
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'keyboard', title: 'Perangkat Input', items: '1. Keyboard\n2. Mouse\n3. Pen Tablet', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                        const SizedBox(width: 10),
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'monitor', title: 'Perangkat Komputer', items: '1. Laptop\n2. Komputer', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                      ]),
                                                      const SizedBox(height: 10),
                                                      Row(children: [
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'harddisk', title: 'Penyimpanan Data', items: '1. Harddisk\n2. SSD Eksternal', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                        const SizedBox(width: 10),
                                                        Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'monitor1', title: 'Software Animasi', items: '1. Blender\n2. Houdini', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                                      ]),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 32, height: 32,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      if (currentPage > 0) {
                                                        pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      } else {
                                                        pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.arrow_back, color: purple, size: 16),
                                                  ),
                                                ),
                                                Text('Slide ${currentPage + 1} dari 2', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, shadows: textShadow)),
                                                Container(
                                                  width: 32, height: 32,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      if (currentPage < 1) {
                                                        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      } else {
                                                        pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.arrow_forward, color: purple, size: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    _showPopupDialog('Peralatan Produksi', peralatanContent);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Baris 3: Panduan Produksi (Ditempatkan di sisi kiri dengan kolom kosong penyeimbang di kanan)
                          Row(
                            children: [
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Panduan Produksi',
                                  subtitle: 'Langkah-langkah membuat dari awal hingga akhir',
                                  assetName: 'buku',
                                  onTap: () {
                                    _showPopupDialog('Panduan Produksi', PanduanData.getPanduanContent(widget.categoryTitle));
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ] else ...[
                          // ===================================================
                          // TATA LETAK STANDAR KATEGORI FILM & PODCAST (4 Shape Menu)
                          // ===================================================
                          Row(
                            children: [
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Tahapan Produksi',
                                  subtitle: 'Pra-Produksi, Produksi dan Pasca-Produksi.',
                                  assetName: 'catatan',
                                  onTap: () {
                                    _showPopupDialog('Tahapan Produksi', PanduanData.getTahapanContent(widget.categoryTitle));
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Peran Kru',
                                  subtitle: 'Tugas dan tanggung jawab setiap kru.',
                                  assetName: 'grup',
                                  onTap: () {
                                    Widget crewContent;
                                    if (cat == 'film') {
                                      crewContent = StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setStateDialog) {
                                          final PageController pageController = PageController();
                                          int currentPage = 0;
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: 380,
                                                child: PageView(
                                                  controller: pageController,
                                                  onPageChanged: (index) {
                                                    setStateDialog(() { currentPage = index; });
                                                  },
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          PanduanData.buildCrewItem('user', 'Produser', 'Bertanggung jawab atas perencanaan, anggaran, dan keseluruhan produksi film.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('clapper', 'Sutradara', 'Mengarahkan pemain dan kru agar film sesuai dengan konsep cerita.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('catatan', 'Penulis Skenario', 'Menulis cerita, dialog, dan alur film.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('megaphone', 'Asisten Sutradara', 'Membantu sutradara mengatur jadwal dan kelancaran proses syuting.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('film', 'Penata Kamera (Cinematographer)', 'Mengatur pengambilan gambar, sudut kamera, dan komposisi visual.', purple, shape, assetIcon),
                                                        ],
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          PanduanData.buildCrewItem('ide', 'Penata Cahaya (Lighting)', 'Mengatur pencahayaan agar sesuai dengan suasana adegan.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('podcast', 'Penata Suara', 'Merekam dan mengatur kualitas dialog serta suara selama produksi.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('kursi', 'Penata Artistik', 'Menyiapkan properti, kostum, dan dekorasi sesuai kebutuhan cerita.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('monitor1', 'Editor Video', 'Menyusun dan menyunting rekaman menjadi film utuh.', purple, shape, assetIcon),
                                                          PanduanData.buildCrewItem('musik', 'Penata Musik', 'Membuat atau memilih musik dan efek suara untuk mendukung suasana film.', purple, shape, assetIcon),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 32, height: 32,
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        if (currentPage > 0) {
                                                          pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                        } else {
                                                          pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                        }
                                                      },
                                                      icon: const Icon(Icons.arrow_back, color: purple, size: 16),
                                                    ),
                                                  ),
                                                  Text('Slide ${currentPage + 1} dari 2', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, shadows: textShadow)),
                                                  Container(
                                                    width: 32, height: 32,
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [softShadow]),
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        if (currentPage < 1) {
                                                          pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                        } else {
                                                          pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                        }
                                                      },
                                                      icon: const Icon(Icons.arrow_forward, color: purple, size: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      crewContent = SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            PanduanData.buildCrewItem('user', 'Produser', 'Bertanggung jawab atas perencanaan, anggaran, dan keseluruhan produksi film.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('host', 'Host', 'Membawakan podcast dan memandu percakapan dengan narasumber.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('catatan', 'Penulis Naskah', 'Menyiapkan naskah, pertanyaan, dan alur pembahasan podcast.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('boom', 'Audio Engineer', 'Mengatur perangkat rekaman dan menjaga kualitas suara.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('audio', 'Sound Editor', 'Menyunting audio, menghilangkan noise, dan mengatur volume suara.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('narasumber', 'Narasumber', 'Menyampaikan informasi atau pengalaman sesuai topik podcast.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('pentol', 'Desainer Grafis', 'Membuat cover dan visual untuk kebutuhan publikasi podcast.', purple, shape, assetIcon),
                                            PanduanData.buildCrewItem('media', 'Tim Publikasi', 'Mengunggah podcast ke platform dan mengatur jadwal publikasi.', purple, shape, assetIcon),
                                          ],
                                        ),
                                      );
                                    }
                                    _showPopupDialog('Peran Kru', crewContent);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Peralatan Produksi',
                                  subtitle: 'Alat dan software yang dibutuhkan',
                                  assetName: 'film',
                                  onTap: () {
                                    Widget peralatanContent = Column(
                                      children: [
                                        Text(
                                          cat == 'film' ? 'Peralatan Produksi Film' : 'Peralatan Produksi Podcast',
                                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: textShadow),
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          children: [
                                            Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'film', title: 'Kamera & Visual', items: cat == 'film' ? '1. Kamera\n2. Lensa\n3. Tripod\n4. Lighting' : '1. Kamera/Webcam\n2. Lighting Studio\n3. Green Screen', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                            const SizedBox(width: 10),
                                            Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'podcast', title: 'Peralatan Audio', items: cat == 'film' ? '1. Microphone\n2. Headphone\n3. Recorder' : '1. Mic Condenser\n2. Audio Interface\n3. Headphone\n4. Boom Arm', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'monitor', title: 'Perangkat Produksi', items: cat == 'film' ? '1. Laptop\n2. Monitor\n3. Software' : '1. Komputer/Laptop\n2. DAW Software\n3. Pop Filter', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                            const SizedBox(width: 10),
                                            Expanded(child: PanduanData.buildPeralatanCardFigma(assetName: 'harddisk', title: 'Penyimpanan & Data', items: cat == 'film' ? '1. Memory card\n2. Hard disk\n3. Baterai' : '1. External SSD/HDD\n2. Cloud Storage\n3. Kabel Data', purple: purple, assetIcon: assetIcon, shapeBox: shape)),
                                          ],
                                        ),
                                      ],
                                    );
                                    _showPopupDialog('Peralatan Produksi', peralatanContent);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildMenuCardPortrait(
                                  title: 'Panduan Produksi',
                                  subtitle: 'Langkah-langkah membuat dari awal hingga akhir',
                                  assetName: 'buku',
                                  onTap: () {
                                    _showPopupDialog('Panduan Produksi', PanduanData.getPanduanContent(widget.categoryTitle));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),

                        // ===================================================
                        // KARTU BAWAH: UJI PEMAHAMAN
                        // ===================================================
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UjiPemahamanPage(
                                  username: widget.username,
                                  categoryTitle: widget.categoryTitle,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: shape(color: purple, radius: 12),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: shape(color: Colors.white, radius: 8),
                                  child: assetIcon('otak', size: 22, color: purple),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Uji Pemahaman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                                      const SizedBox(height: 2),
                                      Text('Uji pemahamanmu tentang ${widget.categoryTitle.toLowerCase()}.', style: const TextStyle(fontSize: 10, color: Colors.white70)),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
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
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membangun kartu menu berbentuk potret dengan dukungan kustom ikon teks
  Widget _buildMenuCardPortrait({
    required String title,
    required String subtitle,
    String? assetName,
    Widget? customIconWidget,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 145,
        padding: const EdgeInsets.all(12),
        decoration: shape(color: cardBgColor, radius: 12, border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customIconWidget ?? Container(
              padding: const EdgeInsets.all(8),
              decoration: shape(color: purple, radius: 8),
              child: assetIcon(assetName!, size: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87),
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 9, color: Colors.grey, height: 1.2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward, size: 14, color: purple),
            ),
          ],
        ),
      ),
    );
  }
}