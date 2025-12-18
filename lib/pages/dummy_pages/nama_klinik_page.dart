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
 // 🔹 Icon mapping (SESUAI NAMA FILE DI FOLDER)
final Map<String, String> poliIcons = {
  "Penyakit Dalam": "assets/images/Penyakitdalam_result.webp",
  "Kulit & Kelamin": "assets/images/kulit_result.webp",
  "Jantung & Pembuluh Darah": "assets/images/jantung_result.webp",
  "Kebidanan & Kandungan": "assets/images/obgyn_result.webp",
  "Anak": "assets/images/anak_result.webp",
  "Mata": "assets/images/mata_result.webp",
  "Neurologi (Syaraf)": "assets/images/syaraf_result.webp",
  "Psikiatri": "assets/images/psikiatri_result.webp",
  "THT": "assets/images/THT_result.webp",
  "Orthopaedi": "assets/images/orthopedi_result.webp",
  "Paru": "assets/images/paru_result.webp",
  "Prostodonsi": "assets/images/gigi_result.webp",
  "Periodonsi": "assets/images/gigi_result.webp",
  "Ozon": "assets/images/ozon_result.webp",
  "Stemcell & Secretome": "assets/images/stemcell_result.webp",
  "Radiologi": "assets/images/radiologi_result.webp",
  "Laboratorium": "assets/images/laboratorium_result.webp",
  "Vaksin Internasional": "assets/images/vaksin_result.webp",
  "Rehabilitasi Medik": "assets/images/rehab_medik_result.webp",
  "Bedah": "assets/images/bedah_result.webp",
  "Terapi Wicara": "assets/images/terapi_wicara_result.webp",
  "Akupunktur Medik": "assets/images/akupunkture_result.webp",
  "Fisioterapi": "assets/images/fisioterapi_result.webp",
  "Laktasi": "assets/images/laktasi_result.webp",
  "Okupasi Terapi": "assets/images/okupasi_result.webp",
  "Hipnoterapi": "assets/images/hipnoterapi_result.webp",
  "Beauty Center": "assets/images/beautycenter_result.webp",
  "Bedah Anak": "assets/images/anak_result.webp",
  "Gigi Umum": "assets/images/gigi_result.webp",
  "Klinik Umum": "assets/images/dokterumum_result.webp",
  "IGD 24 Jam": "assets/images/igd_result.webp",
  "Patologi Klinik": "assets/images/dokterumum_result.webp",
  "Patologi Anatomi": "assets/images/dokterumum_result.webp",
  "Anestesi": "assets/images/bedah_result.webp",
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble_result.webp',
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
