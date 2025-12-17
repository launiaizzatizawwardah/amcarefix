import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/filter_dokter_controller.dart';

class JadwalDokterFilterPage extends StatelessWidget {
  // 🔥 DAFTARKAN controller DI SINI
  final FilterDokterController controller =
      Get.put(FilterDokterController());

  JadwalDokterFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String poli = args['poli'] ?? '';

    // Panggil API sekali saja setelah build
    if (poli.isNotEmpty) {
      Future.microtask(() => controller.fetchDokterByPoli(poli));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble.png',
              fit: BoxFit.cover,
            ),
          ),

          // ================= HEADER =================
          Container(
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8BC0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    poli.isEmpty ? "Dokter Poli" : "Dokter $poli",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendExa',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= CONTENT =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 110, 16, 0),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredList.isEmpty) {
                return const Center(
                  child: Text(
                    "Tidak ada dokter untuk poli ini.",
                    style: TextStyle(fontFamily: 'LexendExa'),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.filteredList.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (_, index) {
                  final d = controller.filteredList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NAMA POLI + DOKTER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  d.namaPoli,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E8BC0),
                                    fontFamily: 'LexendExa',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  d.namaDokter,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'LexendExa',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // JADWAL HARI-JAM
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E8BC0).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: d.jadwal.keys.map((hari) {
                                final jam = d.jadwal[hari] ?? "-";

                                return Container(
                                  width: 80,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          Colors.blueAccent.withOpacity(0.25),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        hari,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8BC0),
                                          fontSize: 12,
                                          fontFamily: 'LexendExa',
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        jam,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.black87,
                                          fontFamily: 'LexendExa',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
