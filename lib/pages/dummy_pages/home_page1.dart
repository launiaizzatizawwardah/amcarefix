import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home1_controller.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';

// Pages
import '../dummy_pages/riwayat_rekam_medis_page.dart';
import '../dummy_pages/layanan_page.dart';
import '../dummy_pages/profile_page.dart';

// Widget
import '../widget/service_card.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.put(Home1Controller());
    final home = Get.put(HomeController());
    final bottomPadding = MediaQuery.of(context).padding.bottom + 16;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        switch (nav.selectedIndex.value) {
          case 0:
            return _beranda(context, bottomPadding, home);
          case 1:
            return RiwayatRekamMedisPage();
          case 2:
            return const LayananPage();
          case 3:
            return const ProfilePage();
          default:
            return _beranda(context, bottomPadding, home);
        }
      }),
      bottomNavigationBar: _bottomNav(nav),
    );
  }

  // ===================== BOTTOM NAV ============================
  Widget _bottomNav(Home1Controller c) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(16),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final icons = [
              Icons.home_rounded,
              Icons.folder_shared_rounded,
              Icons.medical_services_rounded,
              Icons.person_rounded,
            ];

            final labels = ["Beranda", "Riwayat RM", "Layanan", "Akun"];
            final active = c.selectedIndex.value == index;

            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => c.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: active ? Colors.blue.shade50 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icons[index],
                      color: active ? Colors.blueAccent : Colors.grey,
                      size: active ? 28 : 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontFamily: 'LexendExa',
                        fontSize: 11,
                        fontWeight:
                            active ? FontWeight.bold : FontWeight.normal,
                        color: active ? Colors.blueAccent : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  // ======================= BERANDA =============================
  Widget _beranda(
      BuildContext context, double bottomPadding, HomeController home) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _header(),
            ),

            const SizedBox(height: 16),

            // WELCOME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _welcome(),
            ),

            const SizedBox(height: 16),

            // SLIDER PROMO
            _slider(home),

            const SizedBox(height: 20),

            // MENU GRID – TANPA KOTAK APA PUN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildMenuGrid(),
            ),

            const SizedBox(height: 24),

            // PAKET LAYANAN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Paket Layanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LexendExa',
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lihat semua',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'LexendExa',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // LIST LAYANAN
            Obx(() {
              if (home.isLoadingLayanan.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (home.layananList.isEmpty) {
                return const Center(
                  child: Text('Belum ada layanan tersedia.',
                      style: TextStyle(fontFamily: 'LexendExa')),
                );
              }

              return SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: home.layananList.length,
                  itemBuilder: (context, index) {
                    final layanan = home.layananList[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ServiceCard(
                        title: layanan.nama,
                        subtitle: layanan.deskripsi,
                        price: layanan.harga,
                        imageUrl: layanan.fotoUtama,
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ======================= HEADER =============================
  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo_rs.png', width: 35, height: 35),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AMCare',
                style: TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Layanan antrian online',
                style: TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Asri Medical Center Yogyakarta',
                style: TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.support_agent, size: 28, color: Colors.black87),
      ],
    );
  }

  Widget _welcome() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Halo!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'LexendExa',
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Selamat Datang di AmCare',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'LexendExa',
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // ======================= SLIDER =============================
  Widget _slider(HomeController home) {
    final pageController =
        PageController(initialPage: 1000, viewportFraction: 0.85);

    return Obx(() {
      if (home.isLoadingSlider.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (home.sliders.isEmpty) {
        return const Center(child: Text('Belum ada promosi tersedia.'));
      }

      return SizedBox(
        height: 150,
        child: PageView.builder(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final realIndex = index % home.sliders.length;
            final foto = home.sliders[realIndex].foto;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  foto,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  // ======================= MENU GRID ===========================
  Widget _buildMenuGrid() {
    final items = [
      [
        "assets/images/pendaftaran.png",
        "Pendaftaran\nOnline",
        AppRoutes.pendaftaranOnline
      ],
      [
        "assets/images/rekam_medis.png",
        "Riwayat\nRekam Medis",
        AppRoutes.riwayatRekamMedis
      ],
      [
        "assets/images/antrian.png",
        "Pemantauan\nAntrian",
        AppRoutes.pemantauanAntrian
      ],
      ["assets/images/jadwal.png", "Jadwal\nDokter", AppRoutes.jadwalDokter],
      ["assets/images/klinik.png", "Nama\nKlinik", AppRoutes.namaKlinik],
      [
        "assets/images/tempat_tidur.png",
        "Tempat Tidur\nTersedia",
        AppRoutes.tempatTidur
      ],
      [
        "assets/images/farmasi.png",
        "Antrian\nFarmasi",
        AppRoutes.antrianFarmasi
      ],
      ["assets/images/emergency.png", "Emergency", AppRoutes.emergency],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return _menuItem(
          items[index][0],
          items[index][1],
          items[index][2],
        );
      },
    );
  }

  // ==================== MENU ITEM – SERAGAM ====================
  Widget _menuItem(String img, String title, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          // Semua icon dalam kotak 50×50 → ukuran seragam
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Image.asset(
              img,
              width: 34,
              height: 34,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 6),

          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
