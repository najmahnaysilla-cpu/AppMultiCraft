import 'package:flutter/material.dart';
import 'tahapproduksi.dart';

class EdukasiPage extends StatefulWidget {
  final String username;

  const EdukasiPage({
    super.key,
    required this.username,
  });

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  static const Color darkBlue = Color(0xFF182BB5);
  static const Color lightBlue = Color(0xFFB7C5F4);
  static const Color inactiveBlue = Color(0xFF8FA4E5);
  static const Color yellow = Color(0xFFD6D83F);

  // Progress berdasarkan materi yang benar-benar selesai.
  // Untuk sekarang semuanya masih 0.
  final Map<String, int> completedMaterials = {
    'Film': 0,
    'Podcast': 0,
    'Animasi': 0,
  };

  final int totalMaterials = 15;

  // 0 = Film
  // 1 = Podcast
  // 2 = Animasi
  int progressProductionIndex = 0;

  final List<String> productionNames = [
    'Film',
    'Podcast',
    'Animasi',
  ];

  final Set<String> flashingProductions = {};

  String get currentProductionName {
    return productionNames[progressProductionIndex];
  }

  int get currentCompleted {
    return completedMaterials[currentProductionName] ?? 0;
  }

  double get currentProgress {
    return currentCompleted / totalMaterials;
  }

  int get currentPercentage {
    return (currentProgress * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // HEADER DASHBOARD
            // ==================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 5, 14, 18),
              decoration: const BoxDecoration(
                color: lightBlue,
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
                          _message('Menu dipilih');
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: darkBlue,
                          size: 19,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          _message('Belum ada notifikasi baru.');
                        },
                        icon: const Icon(
                          Icons.notifications,
                          color: darkBlue,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Halo, ${widget.username}!',
                    style: const TextStyle(
                      color: darkBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Selamat datang, selamat mempelajari tahapan\nproduksi konten.',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 9,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // ISI DASHBOARD
            // ==================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // KARTU PROGRESS
                    // ==================================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progress $currentProductionName',
                            style: const TextStyle(
                              color: darkBlue,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: CircularProgressIndicator(
                                        value: currentProgress,
                                        strokeWidth: 3,
                                        backgroundColor: lightBlue,
                                        color: darkBlue,
                                      ),
                                    ),
                                    Text(
                                      '$currentPercentage%',
                                      style: const TextStyle(
                                        color: darkBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$currentCompleted/$totalMaterials Materi',
                                      style: const TextStyle(
                                        color: darkBlue,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // INI BERFUNGSI SEBAGAI NEXT:
                                    // Film -> Podcast -> Animasi -> Film
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: _changeProgressView,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: yellow,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Lihat detail',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                              size: 13,
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 13),

                    const Text(
                      'Tahapan Produksi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    _productionCard(
                      imagePath: 'assets/images/film.png',
                      title: 'Film',
                      subtitle: 'Tahapan produksi film',
                    ),

                    const SizedBox(height: 7),

                    _productionCard(
                      imagePath: 'assets/images/podcast.png',
                      title: 'Podcast',
                      subtitle: 'Tahapan produksi podcast',
                    ),

                    const SizedBox(height: 7),

                    _productionCard(
                      imagePath: 'assets/images/animasi.png',
                      title: 'Animasi',
                      subtitle: 'Tahapan produksi animasi',
                    ),
                  ],
                ),
              ),
            ),

            // NAVIGATOR DASHBOARD
            // Background = BIRU MUDA
            // Aktif = BIRU TUA
            // Tidak aktif = BIRU MUDA LEBIH GELAP
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // NEXT PROGRESS
  // ==========================================================

  void _changeProgressView() {
    setState(() {
      progressProductionIndex++;

      if (progressProductionIndex >= productionNames.length) {
        progressProductionIndex = 0;
      }
    });
  }

  // ==========================================================
  // CARD FILM / PODCAST / ANIMASI
  // ==========================================================

  Widget _productionCard({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    final bool isFlashing = flashingProductions.contains(title);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        setState(() {
          flashingProductions.add(title);
        });

        await Future.delayed(
          const Duration(milliseconds: 180),
        );

        if (!mounted) return;

        setState(() {
          flashingProductions.remove(title);
        });

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TahapanProduksiPage(
              username: widget.username,
              productionType: title,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        height: 57,
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: isFlashing ? yellow : Colors.white,
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
              width: 43,
              height: 43,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isFlashing ? Colors.white : darkBlue,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    color: isFlashing ? darkBlue : Colors.white,
                    size: 23,
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

  // ==========================================================
  // NAVIGATOR DASHBOARD
  // ==========================================================

  Widget _bottomNavigation() {
    return Container(
      height: 55,
      color: lightBlue,
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
    // Dashboard = index 0 aktif.
    final bool active = index == 0;

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
              active ? darkBlue : inactiveBlue,
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
                  color: active ? darkBlue : inactiveBlue,
                  size: 20,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == 0) {
      return;
    }

    if (index == 4) {
      // Sudah berada di Buku/Edukasi.
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationPlaceholderPage(
          title: _navigationTitle(index),
          activeIndex: index,
          darkNavigator: false,
          username: widget.username,
        ),
      ),
    );
  }

  String _navigationTitle(int index) {
    switch (index) {
      case 1:
        return 'Jadwal';
      case 2:
        return 'Catatan';
      case 3:
        return 'Folder';
      case 5:
        return 'Pengaturan';
      default:
        return '';
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}

// ============================================================
// PLACEHOLDER NAVIGATOR
// ============================================================

class NavigationPlaceholderPage extends StatelessWidget {
  final String title;
  final int activeIndex;
  final bool darkNavigator;
  final String username;

  const NavigationPlaceholderPage({
    super.key,
    required this.title,
    required this.activeIndex,
    required this.darkNavigator,
    required this.username,
  });

  static const Color darkBlue = Color(0xFF182BB5);
  static const Color lightBlue = Color(0xFFB7C5F4);
  static const Color inactiveBlue = Color(0xFF8FA4E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkNavigator ? lightBlue : darkBlue,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
              decoration: BoxDecoration(
                color: darkNavigator ? darkBlue : lightBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: darkNavigator ? Colors.white : darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Halaman $title',
                  style: TextStyle(
                    color: darkNavigator ? darkBlue : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _navigationBar(context),
          ],
        ),
      ),
    );
  }

  Widget _navigationBar(BuildContext context) {
    return Container(
      height: 55,
      color: darkNavigator ? darkBlue : lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _icon(context, 'assets/images/dashboard.png', 0),
          _icon(context, 'assets/images/jadwal.png', 1),
          _icon(context, 'assets/images/catatan.png', 2),
          _icon(context, 'assets/images/folder.png', 3),
          _icon(context, 'assets/images/buku.png', 4),
          _icon(context, 'assets/images/pengaturan.png', 5),
        ],
      ),
    );
  }

  Widget _icon(
    BuildContext context,
    String imagePath,
    int index,
  ) {
    final bool active = index == activeIndex;

    // INI KUNCI WARNA:
    //
    // Navigator biru muda:
    // aktif = biru tua
    //
    // Navigator biru tua:
    // aktif = putih
    //
    final Color iconColor = active
        ? (darkNavigator ? Colors.white : darkBlue)
        : (darkNavigator ? lightBlue : inactiveBlue);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _goToNavigation(context, index);
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
            ),
          ),
        ),
      ),
    );
  }

  void _goToNavigation(
    BuildContext context,
    int index,
  ) {
    if (index == activeIndex) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationPlaceholderPage(
          title: _title(index),
          activeIndex: index,
          darkNavigator: false,
          username: username,
        ),
      ),
    );
  }

  String _title(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Jadwal';
      case 2:
        return 'Catatan';
      case 3:
        return 'Folder';
      case 4:
        return 'Buku';
      case 5:
        return 'Pengaturan';
      default:
        return '';
    }
  }
}