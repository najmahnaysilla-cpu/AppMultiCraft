import 'package:flutter/material.dart';

class UjiPemahamanPage extends StatefulWidget {
  final String username;
  final String categoryTitle;

  const UjiPemahamanPage({
    super.key,
    required this.username,
    required this.categoryTitle,
  });

  @override
  State<UjiPemahamanPage> createState() => _UjiPemahamanPageState();
}

class _UjiPemahamanPageState extends State<UjiPemahamanPage> {
  static const Color purple = Color(0xFF6757E8);
  
  int? selectedAnswer; // Menyimpan indeks pilihan jawaban user
  bool isSubmitted = false; // Status apakah tombol kirim sudah ditekan
  bool isCorrect = false; // Status apakah jawaban yang dipilih benar

  @override
  Widget build(BuildContext context) {
    final cat = widget.categoryTitle.toLowerCase();

    // Menentukan Pertanyaan, Pilihan Ganda, dan Kunci Jawaban sesuai kategori
    String question;
    List<String> options;
    int correctIndex;

    if (cat == 'podcast') {
      question = 'Peralatan utama untuk merekam suara podcast adalah?';
      options = [
        'A. Tripod',
        'B. Reflektor',
        'C. Mikrofon',
        'D. Clapperboard',
      ];
      correctIndex = 2; // C. Mikrofon
    } else if (cat == 'animasi') {
      question = 'Apa tugas seorang animator?';
      options = [
        'A. Membuat gerakan karakter atau objek',
        'B. Menulis naskah saja',
        'C. Mengatur distribusi film',
        'D. Merekam suara',
      ];
      correctIndex = 0; // A. Membuat gerakan karakter atau objek
    } else {
      // Default: Film
      question = 'Apa yang dilakukan pada tahap pasca produksi film?';
      options = [
        'A. Menentukan ide cerita',
        'B. Menyusun jadwal syuting',
        'C. Melakukan editing video',
        'D. Memilih lokasi syuting',
      ];
      correctIndex = 2; // C. Melakukan editing video
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ATAS HALAMAN KUIS ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              decoration: const BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Uji Pemahaman ${widget.categoryTitle}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // --- KONTEN KUIS / HALAMAN HASIL ---
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: isSubmitted && isCorrect
                        ? _buildResultView() // Tampilan sukses jika jawaban benar
                        : _buildQuestionView(question, options, correctIndex), // Tampilan pertanyaan kuis
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Tampilan Soal & Pilihan Ganda
  Widget _buildQuestionView(String question, List<String> options, int correctIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Looping pilihan ganda A, B, C, D
        ...List.generate(options.length, (index) {
          bool isSelected = selectedAnswer == index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedAnswer = index; // Menandai pilihan user
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFB4E157) : Colors.white, // Berubah hijau jika dipilih
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  options[index],
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 16),

        // Tombol Kirim Jawaban
        SizedBox(
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedAnswer != null ? const Color(0xFFB4E157) : Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: selectedAnswer == null
                ? null
                : () {
                    setState(() {
                      if (selectedAnswer == correctIndex) {
                        isCorrect = true;
                        isSubmitted = true;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Jawaban belum tepat, silakan coba lagi!')),
                        );
                      }
                    });
                  },
            child: const Text(
              'Kirim',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget Tampilan Sukses Ketika Jawaban Benar
  Widget _buildResultView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Jawaban benar!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.assignment_turned_in_rounded,
            size: 64,
            color: purple,
          ),
        ),
        
        const SizedBox(height: 32),

        // Tombol Kembali
        SizedBox(
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB4E157),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Kembali',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}