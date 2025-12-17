import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../routes/app_routes.dart';

class PemantauanAntrianPage extends StatefulWidget {
  const PemantauanAntrianPage({super.key});

  @override
  State<PemantauanAntrianPage> createState() => _PemantauanAntrianPageState();
}

class _PemantauanAntrianPageState extends State<PemantauanAntrianPage> {
  List<dynamic> dataAntrian = [];
  bool isLoading = true;

  String userPoliklinik = 'Poli Umum';
  String userNoAntrian = '12';

  @override
  void initState() {
    super.initState();
    fetchAntrian();
  }

  Future<void> fetchAntrian() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://infoantrian.rsamcmuhammadiyah.com/antrian/getantrianbyunit'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> result;
        if (jsonData is List) {
          result = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          result = jsonData['data'];
        } else {
          result = [];
        }

        setState(() {
          dataAntrian = result;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memuat data antrian')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Color getStatusColor(dynamic panggil) {
    if (panggil == null || panggil.toString() == '0') return Colors.grey[300]!;
    switch (panggil.toString()) {
      case '1':
        return Colors.blue[400]!;
      case '2':
        return Colors.green[400]!;
      default:
        return Colors.grey[300]!;
    }
  }

  String getStatusLabel(dynamic panggil) {
    if (panggil == null || panggil.toString() == '0') return 'Menunggu';
    switch (panggil.toString()) {
      case '1':
        return 'Diperiksa';
      case '2':
        return 'Selesai';
      default:
        return 'Menunggu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🔹 Background marble
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Header biru — judul dekat back button
Container(
  height: 120,
  width: double.infinity,
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
          onPressed: () => Get.offAllNamed(AppRoutes.home1),
        ),

        const SizedBox(width: 6), // jarak kecil biar mepet

        const Text(
          "Pemantauan Antrian",
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


          // 🔹 Konten utama
          Column(
            children: [
              const SizedBox(height: 130),

              // 🔹 Info pasien
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Poliklinik yang dipantau',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontFamily: 'LexendExa',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userPoliklinik,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E8BC0),
                            fontFamily: 'LexendExa',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Nomor Antrian Anda',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontFamily: 'LexendExa',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userNoAntrian,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LexendExa',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 List collapse
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: dataAntrian.length,
                        itemBuilder: (context, index) {
                          final poli = dataAntrian[index];
                          final daftarAntrian =
                              (poli['antrian'] ?? []).toList();

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xFF2E8BC0),
                                ),
                              ),
                              child: ExpansionTile(
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: Text(
                                  poli['poliklinik'] ?? '-',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LexendExa',
                                    color: Color(0xFF2E8BC0),
                                  ),
                                ),
                                subtitle: Text(
                                  "${poli['dokter'] ?? '-'} • Jam: ${poli['jam_praktik'] ?? '-'}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontFamily: 'LexendExa',
                                  ),
                                ),
                                childrenPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        daftarAntrian.map<Widget>((pasien) {
                                      final warna =
                                          getStatusColor(pasien['panggil']);
                                      final status =
                                          getStatusLabel(pasien['panggil']);
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: warna,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                pasien['no_periksa']
                                                        ?.toString() ??
                                                    '-',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                status,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
