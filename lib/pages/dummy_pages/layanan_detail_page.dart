import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import package Font Awesome

class LayananDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int price;

  const LayananDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
  });

  // ==========================================================
  // FUNGSI UNTUK MEMBUKA WHATSAPP
  // ==========================================================
  void _launchWhatsApp({
    required String serviceName,
    required int servicePrice,
  }) async {
    // GANTI NOMOR INI dengan nomor WhatsApp Anda (tanpa tanda '+', gunakan kode negara)
    const String phoneNumber = '628170618400';

    // Format harga dengan separator ribuan (misal: 100000 -> 100.000)
    final String formattedPrice = servicePrice.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    // Pesan otomatis yang akan dikirim
    final String message = "Halo, saya tertarik untuk memesan layanan:\n\n"
        "*Nama Layanan:* $serviceName\n"
        "*Harga:* Rp $formattedPrice\n\n"
        "Mohon informasi langkah selanjutnya untuk pemesanan. Terima kasih.";

    final String encodedMessage = Uri.encodeComponent(message);

    // URL WhatsApp
    final Uri whatsappUrl =
        Uri.parse("whatsapp://send?phone=$phoneNumber&text=$encodedMessage");

    // Fallback URL untuk Android/Web
    final Uri webUrl =
        Uri.parse("https://wa.me/$phoneNumber/?text=$encodedMessage");

    // Cek apakah WhatsApp bisa dibuka
    try {
      if (await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
        // Berhasil membuka aplikasi WhatsApp
        return;
      }
      // Jika gagal membuka aplikasi (misal di iOS atau Android yang tidak ada WhatsApp)
      if (await launchUrl(webUrl, mode: LaunchMode.platformDefault)) {
        // Berhasil membuka via web browser (wa.me)
        return;
      }

      // Jika kedua cara gagal
      Get.snackbar("Error",
          "Gagal membuka WhatsApp. Pastikan aplikasi terinstal atau coba perbarui browser Anda.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error",
          "Terjadi kesalahan saat mencoba membuka WhatsApp: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================================================
      // HEADER
      // ==========================================================
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
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'LexendExa',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ==========================================================
      // BODY DETAIL
      // ==========================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Layanan
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nama Layanan
            Text(
              title,
              style: const TextStyle(
                fontFamily: "LexendExa",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Harga
            Text(
              "Harga: Rp $price",
              style: const TextStyle(
                fontFamily: "LexendExa",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 18),

            // Deskripsi Layanan (Detail)
            const Text(
              "Deskripsi Layanan:",
              style: TextStyle(
                fontFamily: "LexendExa",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: "LexendExa",
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================================
            // TOMBOL WHATSAPP BOOKING (Perbaikan: Hapus 'const' pada ElevatedButton)
            // ==========================================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => _launchWhatsApp(
                  serviceName: title,
                  servicePrice: price,
                ),
                icon: const FaIcon(
                  // Menggunakan FaIcon dari Font Awesome
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  "Pesan Layanan via WhatsApp",
                  style: TextStyle(
                    fontFamily: "LexendExa",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  "Kembali ke Daftar Layanan",
                  style: TextStyle(
                    fontFamily: "LexendExa",
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
