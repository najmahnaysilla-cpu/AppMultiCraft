import 'package:flutter/material.dart';

class TahapanProduksiPage extends StatefulWidget {
  final String username;
  final String productionType;

  const TahapanProduksiPage({
    super.key,
    required this.username,
    required this.productionType,
  });

  @override
  State<TahapanProduksiPage> createState() => _TahapanProduksiPageState();
}

class _TahapanProduksiPageState extends State<TahapanProduksiPage> {
  static const Color darkBlue = Color(0xFF182BB5);
  static const Color lightBlue = Color(0xFFB7C5F4);
  static const Color yellow = Color(0xFFD6D83F);

  final Set<String> flashingStages = {};

  // Buku aktif karena halaman ini berada di dalam Buku.
  int currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 5, 14, 18),
              decoration: const BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          _showMessage('Belum ada notifikasi baru.');
                        },
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Tahapan Produksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Pilih tahapan ${widget.productionType} untuk dipelajari.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // ISI
            // =================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  children: [
                    _stageCard(
                      imagePath: 'assets/images/praproduksi.png',
                      title: 'PRA-PRODUKSI',
                      subtitle: '5 MATERI',
                      page: const PraProduksiPage(),
                    ),

                    const SizedBox(height: 8),

                    _stageCard(
                      imagePath: 'assets/images/produksi.png',
                      title: 'PRODUKSI',
                      subtitle: '5 MATERI',
                      page: const ProduksiPage(),
                    ),

                    const SizedBox(height: 8),

                    _stageCard(
                      imagePath: 'assets/images/pascaproduksi.png',
                      title: 'PASCA-PRODUKSI',
                      subtitle: '5 MATERI',
                      page: const PascaProduksiPage(),
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // NAVIGATOR
            // BIRU TUA
            // AKTIF = PUTIH
            // TIDAK AKTIF = BIRU MUDA
            // =================================================
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CARD TAHAPAN
  // =========================================================

  Widget _stageCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    final bool flashing = flashingStages.contains(title);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        setState(() {
          flashingStages.add(title);
        });

        await Future.delayed(
          const Duration(milliseconds: 180),
        );

        if (!mounted) return;

        setState(() {
          flashingStages.remove(title);
        });

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: flashing ? yellow : Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 49,
              height: 49,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: flashing ? Colors.white : darkBlue,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: flashing ? darkBlue : Colors.white,
                    size: 25,
                  );
                },
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: darkBlue,
              size: 23,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGATOR BAWAH
  // =========================================================

  Widget _bottomNavigation() {
    return Container(
      height: 55,
      color: darkBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomIcon(
            'assets/images/dashboard.png',
            0,
          ),
          _bottomIcon(
            'assets/images/jadwal.png',
            1,
          ),
          _bottomIcon(
            'assets/images/catatan.png',
            2,
          ),
          _bottomIcon(
            'assets/images/folder.png',
            3,
          ),
          _bottomIcon(
            'assets/images/buku.png',
            4,
          ),
          _bottomIcon(
            'assets/images/pengaturan.png',
            5,
          ),
        ],
      ),
    );
  }

  Widget _bottomIcon(
    String imagePath,
    int index,
  ) {
    final bool active = index == currentIndex;

    // BACKGROUND NAVIGATOR = BIRU TUA
    //
    // Aktif     = PUTIH
    // Tidak     = BIRU MUDA
    final Color iconColor = active ? Colors.white : lightBlue;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _handleNavigation(index);
      },
      child: SizedBox(
        width: 42,
        height: 42,
        child: Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
            child: Image.asset(
              imagePath,
              width: 22,
              height: 22,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  color: iconColor,
                  size: 20,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGATOR
  // =========================================================

  void _handleNavigation(int index) {
    // Buku = halaman yang sedang dibuka.
    if (index == 4) {
      return;
    }

    // Dashboard = kembali ke dashboard.
    if (index == 0) {
      Navigator.pop(context);
      return;
    }

    // Navigator lainnya untuk sekarang
    // tetap bisa ditekan dan memberi tanda.
    _showMessage(_navigationName(index));
  }

  String _navigationName(int index) {
    switch (index) {
      case 1:
        return 'Jadwal dipilih';
      case 2:
        return 'Catatan dipilih';
      case 3:
        return 'Folder dipilih';
      case 5:
        return 'Pengaturan dipilih';
      default:
        return '';
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}

// =============================================================
// PRA-PRODUKSI
// =============================================================

class PraProduksiPage extends StatelessWidget {
  const PraProduksiPage({super.key});

  final List<String> materials = const [
    'Ide & Konsep',
    'Riset & Referensi',
    'Perencanaan Konten',
    'Penyusunan Naskah',
    'Storyboard',
  ];

  @override
  Widget build(BuildContext context) {
    return _MaterialPage(
      title: 'PRA-PRODUKSI',
      materials: materials,
    );
  }
}

// =============================================================
// PRODUKSI
// =============================================================

class ProduksiPage extends StatelessWidget {
  const ProduksiPage({super.key});

  final List<String> materials = const [
    'Persiapan Produksi',
    'Pelaksanaan Produksi',
    'Pengambilan Gambar / Audio',
    'Pengarahan',
    'Dokumentasi Produksi',
  ];

  @override
  Widget build(BuildContext context) {
    return _MaterialPage(
      title: 'PRODUKSI',
      materials: materials,
    );
  }
}

// =============================================================
// PASCA-PRODUKSI
// =============================================================

class PascaProduksiPage extends StatelessWidget {
  const PascaProduksiPage({super.key});

  final List<String> materials = const [
    'Editing',
    'Penyusunan',
    'Finishing',
    'Review',
    'Finalisasi',
  ];

  @override
  Widget build(BuildContext context) {
    return _MaterialPage(
      title: 'PASCA-PRODUKSI',
      materials: materials,
    );
  }
}

// =============================================================
// HALAMAN MATERI
// =============================================================

class _MaterialPage extends StatelessWidget {
  final String title;
  final List<String> materials;

  const _MaterialPage({
    required this.title,
    required this.materials,
  });

  static const Color darkBlue = Color(0xFF182BB5);
  static const Color lightBlue = Color(0xFFB7C5F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 5, 14, 18),
              decoration: const BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Daftar materi pada tahap produksi.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(14),
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showMaterialMessage(
                        context,
                        materials[index],
                      );
                    },
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: darkBlue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              materials[index],
                              style: const TextStyle(
                                color: darkBlue,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: darkBlue,
                            size: 21,
                          ),
                          const SizedBox(width: 7),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigator di dalam tahapan:
            // BIRU TUA
            // Buku = PUTIH
            // lainnya = BIRU MUDA
            Container(
              height: 55,
              color: darkBlue,
              child: Center(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/buku.png',
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialMessage(
    BuildContext context,
    String material,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$material dipilih'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}