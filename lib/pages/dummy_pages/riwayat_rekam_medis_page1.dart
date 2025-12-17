import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'riwayat_detail_page.dart';
import '../../models/rekam_medis_model.dart';
import '../../controllers/riwayat_controller.dart';

class RiwayatRekamMedisPage1 extends StatelessWidget {
  RiwayatRekamMedisPage1({super.key});

  final RiwayatController c = Get.put(RiwayatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      /// 🔥 BACKGROUND FULL ATAS–BAWAH
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background-marble.png"),
          fit: BoxFit.cover,
        ),
      ),

      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true, // 🔥 WAJIB agar background FULL sampai bawah
        backgroundColor: Colors.transparent,

        // ⭐ APPBAR – TANPA TOMBOl BACK
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(95),
          child: Container(
            height: 95,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8BC0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const SafeArea(
              child: Center(
                child: Text(
                  "Riwayat Rekam Medis",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'LexendExa',
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ),
        ),

        // ⭐ BODY
        body: Obx(() {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.riwayat.isEmpty) {
            return const Center(
              child: Text(
                "Tidak ada riwayat ditemukan",
                style: TextStyle(fontFamily: "LexendExa", fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 40),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ⭐ INFO PASIEN
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Column(
                        children: [
                          Text(
                            'Nomor Rekam Medis',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'LexendExa',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '098645',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendExa',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Total Kunjungan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'LexendExa',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendExa',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ⭐ LIST RIWAYAT
                Column(
                  children: List.generate(
                    c.riwayat.length,
                    (i) => Column(
                      children: [
                        _buildRiwayatCard(c.riwayat[i], i),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ⭐ CARD RIWAYAT
  Widget _buildRiwayatCard(RekamMedisItem item, int index) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ⭐ TANGGAL
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _extractDay(item.tanggal),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                  Text(
                    item.tanggal,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ⭐ DETAIL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.poli,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LexendExa',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.dokter,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontFamily: 'LexendExa',
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.verified_user,
                        color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Asuransi',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'LexendExa',
                      ),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      "BPJS",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontFamily: 'LexendExa',
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: Get.context!,
                          barrierDismissible: true,
                          barrierLabel: "Detail",
                          transitionDuration:
                              const Duration(milliseconds: 250),
                          pageBuilder: (_, __, ___) =>
                              DetailRiwayatRekamMedis(data: item),
                        );
                      },
                      child: const Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'LexendExa',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _extractDay(String date) {
    try {
      return date.split("-").last;
    } catch (_) {
      return "-";
    }
  }
}
