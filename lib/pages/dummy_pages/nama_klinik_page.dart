import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/routes/app_routes.dart';

class NamaPoliklinikPage extends StatelessWidget {
  NamaPoliklinikPage({super.key});

  // 🔹 Daftar poliklinik sesuai API
  final List<String> klinikList = [
    "Penyakit Dalam",
    "Kulit & Kelamin",
    "Jantung & Pembuluh Darah",
    "Kebidanan & Kandungan",
    "Anak",
    "Mata",
    "Neurologi (Syaraf)",
    "Psikiatri",
    "THT",
    "Orthopaedi",
    "Paru",
    "Prostodonsi",
    "Periodonsi",
    "Ozon",
    "Stemcell & Secretome",
    "Radiologi",
    "Laboratorium",
    "Vaksin Internasional",
    "Rehabilitasi Medik",
    "Bedah",
    "Terapi Wicara",
    "Akupunktur Medik",
    "Fisioterapi",
    "Laktasi",
    "Okupasi Terapi",
    "Hipnoterapi",
    "Beauty Center",
    "Bedah Anak",
    "Gigi Umum",
    "Klinik Umum",
    "IGD 24 Jam",
    "Patologi Klinik",
    "Patologi Anatomi",
    "Anestesi",
  ];

  // 🔹 Icon mapping
  final Map<String, String> poliIcons = {
    "Penyakit Dalam": "assets/images/penyakitdalam.png",
    "Kulit & Kelamin": "assets/images/kulit.png",
    "Jantung & Pembuluh Darah": "assets/images/jantung.png",
    "Kebidanan & Kandungan": "assets/images/obgyn.png",
    "Anak": "assets/images/anak.png",
    "Mata": "assets/images/mata.png",
    "Neurologi (Syaraf)": "assets/images/syaraf.png",
    "Psikiatri": "assets/images/psikiatri.png",
    "THT": "assets/images/THT.png",
    "Orthopaedi": "assets/images/orthopedi.png",
    "Paru": "assets/images/paru.png",
    "Prostodonsi": "assets/images/gigi.png",
    "Periodonsi": "assets/images/gigi.png",
    "Ozon": "assets/images/ozon.png",
    "Stemcell & Secretome": "assets/images/stemcell.png",
    "Radiologi": "assets/images/radiologi.png",
    "Laboratorium": "assets/images/dokterumum.png",
    "Vaksin Internasional": "assets/images/vaksin.png",
    "Rehabilitasi Medik": "assets/images/rehab_medik.png",
    "Bedah": "assets/images/bedah.png",
    "Terapi Wicara": "assets/images/terapi_wicara.png",
    "Akupunktur Medik": "assets/images/akupunkture.png",
    "Fisioterapi": "assets/images/fisioterapi.png",
    "Laktasi": "assets/images/laktasi.png",
    "Okupasi Terapi": "assets/images/okupasi.png",
    "Hipnoterapi": "assets/images/hipnoterapi.png",
    "Beauty Center": "assets/images/beautycenter.png",
    "Bedah Anak": "assets/images/anak.png",
    "Gigi Umum": "assets/images/gigi.png",
    "Klinik Umum": "assets/images/dokterumum.png",
    "IGD 24 Jam": "assets/images/igd.png",
    "Patologi Klinik": "assets/images/dokterumum.png",
    "Patologi Anatomi": "assets/images/dokterumum.png",
    "Anestesi": "assets/images/bedah.png",
  };

  @override
  Widget build(BuildContext context) {
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
            height: 95,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8BC0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: const [
                  BackButton(color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "Nama Poliklinik",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'LexendExa',
                    ),
                  )
                ],
              ),
            ),
          ),

          // ================= LIST POLIKLINIK =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 110, 16, 0),
            child: ListView.builder(
              itemCount: klinikList.length,
              itemBuilder: (_, index) {
                final klinik = klinikList[index];

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.jadwalDokterFilter, // 🔥 FIX: route filter dokter
                      arguments: {
                        "poli": klinik,
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              poliIcons[klinik] ?? "assets/images/default.png",
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              klinik,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'LexendExa',
                                color: Color(0xFF2E8BC0),
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black45),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
