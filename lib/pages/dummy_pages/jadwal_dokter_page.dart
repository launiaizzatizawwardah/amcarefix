import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/poliklinik_controller.dart';
import '/routes/app_routes.dart';

class JadwalDokterPage extends StatelessWidget {
  final PoliklinikController controller = Get.put(PoliklinikController());

  JadwalDokterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String from = args["from"] ?? "home";
    final String? selectedPoli = args["poli"];

    // ============================================================
    // 🔥 FILTER POLI HANYA JIKA DATANG DARI HALAMAN POLIKLINIK
    // ============================================================
    Future.microtask(() {
      if (from == "klinik" && selectedPoli != null) {
        ever(controller.dokterList, (_) {
          controller.filterByKlinik(selectedPoli);
        });

        if (controller.dokterList.isNotEmpty) {
          controller.filterByKlinik(selectedPoli);
        }
      } else {
        // Jika dari homepage → tampilkan semua dokter
        controller.filteredList.value = controller.dokterList;
      }
    });

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
                    onPressed: () {
                      if (from == "klinik") {
                        Get.back();
                      } else {
                        Get.offAllNamed(AppRoutes.home1);
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Jadwal Dokter",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= CONTENT =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 110, 16, 0),
            child: Column(
              children: [
                // SEARCH BAR
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Dokter atau Poliklinik',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: controller.searchPoliklinik,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= LIST DOKTER =================
                Expanded(
                  child: Obx(() {
                    // ================= LOADING =================
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2E8BC0),
                        ),
                      );
                    }

                    final list = controller.filteredList;

                    if (list.isEmpty) {
                      return const Center(
                        child: Text(
                          "Tidak ada dokter tersedia",
                          style: TextStyle(
                            fontFamily: 'LexendExa',
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        final item = list[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ================= INFO DOKTER =================
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.namaPoli,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8BC0),
                                          fontSize: 15,
                                          fontFamily: 'LexendExa',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.namaDokter,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                          fontSize: 13,
                                          fontFamily: 'LexendExa',
                                        ),
                                      ),
                                    ],
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.pendaftaranOnline);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2E8BC0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Reservasi',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'LexendExa',
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),

                              // ================= JADWAL (RAPI & SCROLLABLE) =================
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E8BC0).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),

                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: item.jadwal.keys.map((hari) {
                                      final jam = item.jadwal[hari] ?? "-";

                                      return Container(
                                        width: 80,
                                        margin: const EdgeInsets.symmetric(horizontal: 6),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blueAccent.withOpacity(0.25),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            )
                                          ],
                                        ),

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              hari,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2E8BC0),
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
                                                height: 1.2,
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
          ),
        ],
      ),
    );
  }
}
