import 'package:flutter/material.dart';

// =====================================================================
// KELAS PANDUAN DATA
// Berfungsi untuk menyediakan data teks materi (Tahapan, Panduan, Kru, Peralatan)
// yang dibedakan secara spesifik per kategori (Film, Podcast, Animasi).
// =====================================================================
class PanduanData {
  
  // Efek bayangan teks global untuk konsistensi desain Figma
  static List<Shadow> get textShadow => [
        Shadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 2),
          blurRadius: 3,
        ),
      ];

  // 1. Mengembalikan konten data "Tahapan Produksi" berdasarkan kategori
  static Widget getTahapanContent(String categoryTitle) {
    final cat = categoryTitle.toLowerCase();

    // Konten Tahapan: Kategori Film
    if (cat == 'film') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pra-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap perencanaan sebelum proses syuting dimulai.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Menentukan ide dan konsep cerita.\n'
            '2. Membuat sinopsis dan naskah.\n'
            '3. Membuat storyboard dan shot list.\n'
            '4. Menentukan kru dan pemain.\n'
            '5. Menyiapkan alat, lokasi, jadwal, dan anggaran.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white38, thickness: 1),
          const SizedBox(height: 8),
          Text('Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap pelaksanaan pengambilan gambar dan suara sesuai rencana.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Melakukan pengambilan gambar.\n'
            '2. Mengatur kamera dan pencahayaan.\n'
            '3. Merekam dialog dan suara.\n'
            '4. Mengarahkan pemain.\n'
            '5. Memeriksa hasil rekaman.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white38, thickness: 1),
          const SizedBox(height: 8),
          Text('Pasca-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap penyuntingan dan penyelesaian film hingga siap dipublikasikan.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Menyunting dan menyusun video.\n'
            '2. Menambahkan musik dan efek suara.\n'
            '3. Melakukan koreksi warna.\n'
            '4. Menambahkan teks dan subtitle.\n'
            '5. Melakukan rendering dan evaluasi hasil akhir.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
        ],
      );
    }

    // Konten Tahapan: Kategori Podcast
    if (cat == 'podcast') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pra-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap persiapan sebelum proses rekaman dimulai.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Menentukan topik dan konsep podcast.\n'
            '2. Menentukan target pendengar.\n'
            '3. Membuat naskah atau daftar pertanyaan.\n'
            '4. Menentukan host dan narasumber.\n'
            '5. Menyiapkan mikrofon, headphone, dan tempat rekaman.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white38, thickness: 1),
          const SizedBox(height: 8),
          Text('Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap pelaksanaan perekaman suara sesuai rencana.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Menyiapkan peralatan rekaman.\n'
            '2. Mengatur posisi mikrofon dan volume audio.\n'
            '3. Melakukan rekaman suara host dan narasumber.\n'
            '4. Menjaga kejelasan suara selama rekaman.\n'
            '5. Memeriksa hasil rekaman.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white38, thickness: 1),
          const SizedBox(height: 8),
          Text('Pasca-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
          const SizedBox(height: 4),
          const Text('Tahap penyuntingan audio hingga siap dipublikasikan.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
          const SizedBox(height: 6),
          const Text(
            '1. Memotong bagian rekaman yang tidak diperlukan.\n'
            '2. Mengurangi noise atau suara pengganggu.\n'
            '3. Mengatur volume dan kualitas audio.\n'
            '4. Menambahkan musik pembuka dan penutup.\n'
            '5. Mengekspor audio dan mempublikasikan podcast.',
            style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
          ),
        ],
      );
    }

    // Konten Tahapan: Kategori Animasi
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pra-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
        const SizedBox(height: 4),
        const Text('Tahap persiapan sebelum proses pembuatan animasi dimulai.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
        const SizedBox(height: 6),
        const Text(
          '1. Menentukan ide dan konsep cerita.\n'
          '2. Menulis naskah dan dialog.\n'
          '3. Membuat storyboard.\n'
          '4. Mendesain karakter dan objek.\n'
          '5. Menyiapkan kebutuhan animasi.',
          style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
        ),
        const SizedBox(height: 12),
        const Divider(color: Colors.white38, thickness: 1),
        const SizedBox(height: 8),
        Text('Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
        const SizedBox(height: 4),
        const Text('Tahap pembuatan dan penggerakan aset animasi sesuai konsep.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
        const SizedBox(height: 6),
        const Text(
          '1. Membuat model karakter dan objek.\n'
          '2. Memberikan material dan tekstur.\n'
          '3. Melakukan rigging pada karakter jika diperlukan.\n'
          '4. Menganimasikan karakter dan objek.\n'
          '5. Mengatur kamera dan pencahayaan.',
          style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
        ),
        const SizedBox(height: 12),
        const Divider(color: Colors.white38, thickness: 1),
        const SizedBox(height: 8),
        Text('Pasca-Produksi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, shadows: textShadow)),
        const SizedBox(height: 4),
        const Text('Tahap penyempurnaan animasi hingga siap dipublikasikan.', style: TextStyle(color: Colors.white70, fontSize: 9.5)),
        const SizedBox(height: 6),
        const Text(
          '1. Melakukan rendering animasi.\n'
          '2. Menyunting hasil animasi.\n'
          '3. Menambahkan musik dan efek suara.\n'
          '4. Memeriksa kualitas visual dan audio.\n'
          '5. Mengekspor video akhir.',
          style: TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.4),
        ),
      ],
    );
  }

  // 2. Mengembalikan konten data "Panduan Produksi" BESERTA TIPS yang BERBEDA di tiap kategori
  static Widget getPanduanContent(String categoryTitle) {
    final cat = categoryTitle.toLowerCase();

    // --- PANDUAN PRODUKSI & TIPS: KATEGORI FILM ---
    if (cat == 'film') {
      return Column(
        children: [
          _buildPanduanCardItem(title: '1. Pra-Produksi Film', desc: 'Menentukan ide cerita, menulis naskah film, membuat storyboard visual, dan menyusun jadwal serta lokasi syuting.', shadows: textShadow),
          const SizedBox(height: 10),
          _buildPanduanCardItem(title: '2. Produksi Film', desc: 'Melakukan pengambilan gambar video, mengatur penataan pencahayaan (lighting), dan merekam dialog audio secara profesional.', shadows: textShadow),
          const SizedBox(height: 10),
          _buildPanduanCardItem(title: '3. Pasca-Produksi Film', desc: 'Mengedit video film, menambahkan musik latar & efek suara, melakukan color grading, lalu mengekspor hasil akhir.', shadows: textShadow),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Tips Produksi Film', style: TextStyle(color: const Color(0xFF6757E8), fontWeight: FontWeight.bold, fontSize: 12, shadows: textShadow))),
                const SizedBox(height: 8),
                const Text(
                  '1. Pastikan pencahayaan saat syuting film sudah stabil dan terang.\n'
                  '2. Gunakan mikrofon terpisah untuk menjaga kejernihan dialog.\n'
                  '3. Buat shot list yang jelas agar proses pengambilan gambar efisien.\n'
                  '4. Lakukan backup rekaman video secara rutin ke penyimpanan eksternal.\n'
                  '5. Periksa kesesuaian audio dan video pada tahap editing.',
                  style: TextStyle(color: Colors.black87, fontSize: 9.5, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // --- PANDUAN PRODUKSI & TIPS: KATEGORI PODCAST ---
    if (cat == 'podcast') {
      return Column(
        children: [
          _buildPanduanCardItem(title: '1. Pra-Produksi Podcast', desc: 'Menentukan topik/nifas pembahasan, menyusun daftar pertanyaan interaktif, serta menyiapkan studio rekaman audio.', shadows: textShadow),
          const SizedBox(height: 10),
          _buildPanduanCardItem(title: '2. Produksi Podcast', desc: 'Melakukan sesi rekaman suara host dan narasumber dengan menjaga jarak mikrofon dan menghindari suara bising.', shadows: textShadow),
          const SizedBox(height: 10),
          _buildPanduanCardItem(title: '3. Pasca-Produksi Podcast', desc: 'Menyunting file audio, menghilangkan noise/dengung, memasukkan jingle/musik pembuka, dan mengekspor podcast.', shadows: textShadow),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Tips Produksi Podcast', style: TextStyle(color: const Color(0xFF6757E8), fontWeight: FontWeight.bold, fontSize: 12, shadows: textShadow))),
                const SizedBox(height: 8),
                const Text(
                  '1. Gunakan ruangan kedap suara atau minim pantulan suara.\n'
                  '2. Posisikan mikrofon dekat dengan mulut namun gunakan pop filter.\n'
                  '3. Lakukan uji coba (sound check) sebelum rekaman dimulai.\n'
                  '4. Buat alur percakapan yang mengalir dan santai.\n'
                  '5. Berikan intro dan outro audio yang khas untuk podcast Anda.',
                  style: TextStyle(color: Colors.black87, fontSize: 9.5, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // --- PANDUAN PRODUKSI & TIPS: KATEGORI ANIMASI ---
    return Column(
      children: [
        _buildPanduanCardItem(title: '1. Pra-Produksi Animasi', desc: 'Membuat konsep cerita animasi, menulis naskah skenario, merancang storyboard, dan mendesain karakter 2D/3D.', shadows: textShadow),
        const SizedBox(height: 10),
        _buildPanduanCardItem(title: '2. Produksi Animasi', desc: 'Melakukan proses modeling, rigging tulang karakter, pemberian tekstur, pembuatan keyframe animasi, serta lighting.', shadows: textShadow),
        const SizedBox(height: 10),
        _buildPanduanCardItem(title: '3. Pasca-Produksi Animasi', desc: 'Melakukan rendering adegan, menyunting urutan video animasi, menyelaraskan sound effect, dan export file akhir.', shadows: textShadow),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Tips Produksi Animasi', style: TextStyle(color: const Color(0xFF6757E8), fontWeight: FontWeight.bold, fontSize: 12, shadows: textShadow))),
              const SizedBox(height: 8),
              const Text(
                '1. Buat animatic atau storyboard bergerak untuk melihat durasi adegan.\n'
                '2. Perhatikan prinsip dasar animasi (timing dan spacing) agar gerakan luwes.\n'
                '3. Kelompokkan layer aset dan folder project dengan rapi.\n'
                '4. Lakukan render uji coba dengan resolusi rendah terlebih dahulu.\n'
                '5. Simpan file project secara berkala untuk menghindari kehilangan data.',
                style: TextStyle(color: Colors.black87, fontSize: 9.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget helper privat untuk kartu panduan produksi
  static Widget _buildPanduanCardItem({required String title, required String desc, required List<Shadow> shadows}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: const Color(0xFF6757E8), fontWeight: FontWeight.bold, fontSize: 11.5, shadows: shadows)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.black87, fontSize: 9.5, height: 1.3)),
        ],
      ),
    );
  }

  // 3. Widget pembuat item daftar "Peran Kru"
  static Widget buildCrewItem(
    String iconName,
    String roleTitle,
    String roleDesc,
    Color purpleColor,
    BoxDecoration Function({Color color, double radius, Border? border}) shapeBox,
    Widget Function(String, {double size, Color? color}) getAssetIcon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: shapeBox(color: const Color(0xFF7B70EE), radius: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: shapeBox(color: Colors.white, radius: 8),
            child: getAssetIcon(iconName, size: 18, color: purpleColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(roleTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.5)),
                const SizedBox(height: 4),
                Text(roleDesc, style: const TextStyle(color: Colors.white70, fontSize: 9.5, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Widget pembuat kartu "Peralatan Produksi" dengan tinggi tetap agar konsisten dan tidak menyong
  static Widget buildPeralatanCardFigma({
    required String assetName,
    required String title,
    required String items,
    required Color purple,
    required Widget Function(String, {double size, Color? color}) assetIcon,
    required BoxDecoration Function({Color color, double radius, Border? border}) shapeBox,
  }) {
    return Container(
      height: 142, // Menyamakan tinggi card agar konsisten dan tidak menyong
      padding: const EdgeInsets.all(12),
      decoration: shapeBox(color: Colors.white, radius: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFF7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: assetIcon(assetName, size: 22, color: purple),
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              items,
              style: const TextStyle(color: Colors.black87, fontSize: 9, height: 1.25),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}