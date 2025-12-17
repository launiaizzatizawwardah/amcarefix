import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'layanan_detail_page.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF1E88E5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 40,
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: Row(
            children: const [
              SizedBox(width: 10),
              Text(
                "Paket Layanan",
                style: TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (home.isLoadingLayanan.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (home.layananList.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada layanan tersedia.",
              style: TextStyle(fontFamily: "LexendExa"),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: home.layananList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              final layanan = home.layananList[index];

              return _buildServiceCard(
                title: layanan.nama,
                subtitle: _cleanHtml(layanan.deskripsi),
                imageUrl: layanan.fotoUtama,
                price: int.tryParse(
                        layanan.harga.replaceAll(RegExp(r'[^0-9]'), '')) ??
                    0,
              );
            },
          ),
        );
      }),
    );
  }

  String _cleanHtml(String html) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(regex, '').replaceAll('&nbsp;', ' ').trim();
  }

  // Format angka ke "Rp 150.000"
  String _formatPrice(int price) {
    if (price <= 0) return ""; // harga 0 → tidak tampil

    String number = price.toString();
    StringBuffer buffer = StringBuffer();
    int count = 0;

    // Sisipkan titik per 3 digit dari belakang
    for (int i = number.length - 1; i >= 0; i--) {
      buffer.write(number[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }

    // Balik lagi
    String formatted = buffer.toString().split('').reversed.join();

    return "Rp $formatted";
  }

  // ==========================================================
  // CARD LAYANAN
  // ==========================================================
  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    required int price,
  }) {
    void navigateToDetail() {
      Get.to(
        () => LayananDetailPage(
          title: title,
          subtitle: subtitle,
          imageUrl: imageUrl,
          price: price,
        ),
      );
    }

    final formattedPrice = _formatPrice(price);

    return GestureDetector(
      onTap: navigateToDetail,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.45),
                  Colors.white.withOpacity(0.22),
                  Colors.white.withOpacity(0.10),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.55),
                width: 1.1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.45),
                  blurRadius: 25,
                  spreadRadius: -10,
                  offset: const Offset(-6, -6),
                ),
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.22),
                  blurRadius: 40,
                  spreadRadius: 8,
                  offset: const Offset(6, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'LexendExa',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'LexendExa',
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),

                const Spacer(),

                // Harga + Tombol Detail
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Harga tampil hanya jika > 0
                    if (formattedPrice.isNotEmpty)
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        ),
                      ),

                    GestureDetector(
                      onTap: navigateToDetail,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Detail",
                          style: TextStyle(
                            fontFamily: 'LexendExa',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
