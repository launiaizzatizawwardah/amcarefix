import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/routes/app_routes.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.95, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Gagal Membuka", "Tidak dapat membuka $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-marble.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // ================= HEADER (TETAP) =================
              Container(
                height: 105,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E8BC0), Color(0xFF145DA0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white),
                          onPressed: () => Get.offAllNamed(AppRoutes.home1),
                        ),
                        const SizedBox(width: 6),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Emergency",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'LexendExa',
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Hubungi IGD 24 jam saat darurat",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                                fontFamily: 'LexendExa',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= TOMBOL DARURAT SIRINE =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _launchURL("tel:0274618224"),
                      child: SizedBox(
                        height: 190,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Lingkaran besar memancar (pulse)
                                  Container(
                                    width: 170 * _scale.value,
                                    height: 170 * _scale.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red
                                          .withOpacity(0.18 * _scale.value),
                                    ),
                                  ),

                                  // Lingkaran utama tombol darurat
                                  Container(
                                    width: 135,
                                    height: 135,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFF3B30),
                                          Color(0xFFFF6B4A),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.4),
                                          blurRadius: 18,
                                          offset: const Offset(0, 6),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // ========== ICON SIRINE KELAP-KELIP ==========
                                        AnimatedBuilder(
                                          animation: _controller,
                                          builder: (_, __) {
                                            return Opacity(
                                              opacity: 0.5 +
                                                  (_controller.value * 0.5),
                                              child: Transform.translate(
                                                offset: Offset(
                                                  (_controller.value - 0.5) * 4,
                                                  0,
                                                ),
                                                child: const FaIcon(
                                                  FontAwesomeIcons.ambulance,


                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        const SizedBox(height: 6),
                                        const Text(
                                          "PANGGIL",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'LexendExa',
                                          ),
                                        ),
                                        const Text(
                                          "DARURAT",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'LexendExa',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Tekan tombol merah saat kondisi gawat darurat.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontFamily: 'LexendExa',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= LIST KONTAK =================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        "Kontak Lainnya",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendExa',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // _buildContactCard(
                      //   title: 'Emergency Call IGD',
                      //   number: '(0274) 618224',
                      //   icon: Icons.local_hospital,
                      //   color: Colors.red,
                      //   label: "Panggilan IGD 24 Jam",
                      //   onPressed: () => _launchURL("tel:0274618224"),
                      // ),

                      _buildContactCard(
                        title: 'Call Center',
                        number: '(0274) 618400',
                        icon: Icons.call,
                        color: Colors.blue,
                        label: "Informasi & Konsultasi",
                        onPressed: () => _launchURL("tel:0274618400"),
                      ),

                      _buildContactCard(
                        title: 'WhatsApp',
                        number: '+62 817 0618 400',
                        icon: FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        label: "Chat dengan petugas",
                        onPressed: () =>
                            _launchURL("https://wa.me/628170618400"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String number,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
