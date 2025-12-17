import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/routes/app_routes.dart';

class TempatTidurPage extends StatelessWidget {
  final List<Map<String, dynamic>> bangsalList = [
    {'nama': 'Kelas 1', 'tersedia': 4},
    {'nama': 'Standard', 'tersedia': 7},
    {'nama': 'Orchid (VIP)', 'tersedia': 2},
    {'nama': 'Kelas 2', 'tersedia': 5},
    {'nama': 'Kelas 3', 'tersedia': 9},
    {'nama': 'ICU', 'tersedia': 1},
    {'nama': 'Isolasi', 'tersedia': 3},
  ];

  TempatTidurPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF2E8BC0);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🔹 Background marble (tetap)
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Header Biru (lebih naik)
          Container(
            height: 95,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.offAllNamed(AppRoutes.home1),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Ketersediaan Tempat Tidur",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'LexendExa',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // 🔹 Konten Utama
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
            child: Column(
              children: [
                // ============================
                // *DIPINDAH KE DALAM LISTVIEW*
                // ============================

                // 🔹 Semua konten akan scroll
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: bangsalList.length + 1, // +1 untuk teks di atas
                    itemBuilder: (context, index) {
                      // -------------------------
                      // ITEM PERTAMA → TEKS ATAS
                      // -------------------------
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: const [
                              Text(
                                "Pilih kelas bangsal untuk melihat ketersediaan tempat tidur.",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontFamily: 'LexendExa',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      }

                      // --------------------------------
                      // ITEM BERIKUTNYA → KARTU BANGSAL
                      // --------------------------------
                      final item = bangsalList[index - 1];
                      final int tersedia = item['tersedia'] as int;
                      final bool isAvailable = tersedia > 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.96),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: primary.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Icon Bed bulat
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary.withOpacity(0.1),
                              ),
                              child: const Icon(
                                Icons.bed_rounded,
                                color: primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Nama + info tersedia
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['nama'],
                                    style: const TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'LexendExa',
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "$tersedia tempat tidur tersedia",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'LexendExa',
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        isAvailable
                                            ? Icons.check_circle_rounded
                                            : Icons.cancel_rounded,
                                        size: 14,
                                        color: isAvailable
                                            ? Colors.green
                                            : Colors.redAccent,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isAvailable
                                            ? "Status: Tersedia"
                                            : "Status: Penuh",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'LexendExa',
                                          color: isAvailable
                                              ? Colors.green.shade700
                                              : Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Angka badge besar
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
