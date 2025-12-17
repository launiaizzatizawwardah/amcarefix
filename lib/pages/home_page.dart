// File: home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import './widget/service_card.dart'; // ServiceCard yang sudah diperbaiki

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AuthController authController;
  late final HomeController homeController;

  late final AnimationController _animController;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _bannerSlide;
  late final Animation<double> _bannerFade;
  late final Animation<Offset> _menuSlide;
  late final Animation<double> _menuFade;
  late final Animation<Offset> _bottomNavSlide;

  // PageController untuk Slider
  late final PageController _pageController;
  final int _initialPage = 1000;
  bool _isPageAnimating = false;
  int _currentSliderIndex = 0;

  int _selectedBottomIndex = 0;

  @override
  void initState() {
    super.initState();

    authController = Get.find<AuthController>();
    homeController = Get.put(HomeController());

    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: _initialPage,
    );
    _pageController.addListener(_pageListener);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // --- Inisialisasi Animasi ---
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );
    _headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );
    _bannerSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.55, curve: Curves.easeOut),
      ),
    );
    _bannerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
      ),
    );
    _menuSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _menuFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.45, 0.95, curve: Curves.easeOut),
      ),
    );
    _bottomNavSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();
    _startAutoplay();
  }

  void _pageListener() {
    int? newIndex = _pageController.page?.round();
    if (newIndex != null && homeController.sliders.isNotEmpty) {
      if (newIndex % homeController.sliders.length != _currentSliderIndex) {
        setState(() {
          _currentSliderIndex = newIndex % homeController.sliders.length;
        });
      }
    }
  }

  void _startAutoplay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Future.delayed(const Duration(seconds: 4), () async {
        if (!mounted) return;

        if (_pageController.hasClients && homeController.sliders.isNotEmpty) {
          if (!_isPageAnimating) {
            _isPageAnimating = true;
            _pageController
                .nextPage(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
            )
                .then((_) {
              if (mounted) {
                _isPageAnimating = false;
                _startAutoplay();
              }
            });
          } else {
            Future.delayed(
                const Duration(milliseconds: 500), () => _startAutoplay());
          }
        } else {
          Future.delayed(
              const Duration(milliseconds: 500), () => _startAutoplay());
        }
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung padding yang dibutuhkan di bagian bawah konten untuk floating nav
    final bottomPaddingForContent = MediaQuery.of(context).padding.bottom + 80;

    return Scaffold(
      backgroundColor: Colors.white,

      // ===================== APPBAR =====================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_rs.png', width: 35, height: 35),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AMCare',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'LexendExa',
                          )),
                      Text('Layanan antrian online',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                              fontFamily: 'LexendExa')),
                      Text('Asri Medical Center Yogyakarta',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                              fontFamily: 'LexendExa')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.support_agent,
                    color: Colors.black87, size: 28),
                onPressed: () {}),
            const SizedBox(width: 8),
          ],
        ),
      ),

      // ===================== BODY =====================
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPaddingForContent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER (Halo + tombol daftar) ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 16, left: 4, right: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Halo!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LexendExa',
                                  )),
                              SizedBox(height: 2),
                              Text('Selamat Datang di AmCare',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontFamily: 'LexendExa',
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 16,
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.login),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Daftar Sekarang!',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ---------- ⭐ BANNER PROMO (Parallax Scale dan Sisi Terlihat) ⭐ ----------
            FadeTransition(
              opacity: _bannerFade,
              child: SlideTransition(
                position: _bannerSlide,
                child: Obx(() {
                  if (homeController.isLoadingSlider.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (homeController.sliders.isEmpty) {
                    return const Center(
                        child: Text('Belum ada promosi tersedia.'));
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: homeController.sliders.length * 1000,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final realIndex =
                                index % homeController.sliders.length;
                            final slider = homeController.sliders[realIndex];

                            double scale = 1.0;
                            // Logika Parallax Scale
                            if (_pageController.position.hasPixels) {
                              final page = _pageController.page ?? 0.0;
                              final distance = (page - index).abs();
                              scale = (1 - distance * 0.07).clamp(0.93, 1.0);
                            }

                            return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double animatedScale = scale;
                                if (_pageController.position.hasPixels) {
                                  final page = _pageController.page ?? 0.0;
                                  final distance = (page - index).abs();
                                  animatedScale =
                                      (1 - distance * 0.07).clamp(0.93, 1.0);
                                }
                                return Transform.scale(
                                  scale: animatedScale,
                                  child: child,
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    slider.foto,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.grey.shade200,
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // DOT INDICATOR DIHILANGKAN
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- MENU GRID (Sesuai Gambar) ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FadeTransition(
                opacity: _menuFade,
                child: SlideTransition(
                  position: _menuSlide,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final menuItems = [
                          _buildMenuItem(
                            index: 0,
                            imagePath: 'assets/images/pendaftaran.png',
                            title: 'Pendaftaran\nOnline',
                            route: AppRoutes.pendaftaranOnline,
                          ),
                          _buildMenuItem(
                            index: 1,
                            imagePath: 'assets/images/rekam_medis.png',
                            title: 'Riwayat\nRekam Medis',
                            route: AppRoutes.riwayatRekamMedis,
                          ),
                          _buildMenuItem(
                            index: 2,
                            imagePath: 'assets/images/antrian.png',
                            title: 'Pemantauan\nAntrian',
                            route: AppRoutes.pemantauanAntrian,
                          ),
                          _buildMenuItem(
                            index: 3,
                            imagePath: 'assets/images/jadwal.png',
                            title: 'Jadwal\nDokter',
                            route: AppRoutes.jadwalDokter,
                          ),
                          _buildMenuItem(
                            index: 4,
                            imagePath: 'assets/images/klinik.png',
                            title: 'Nama\nKlinik',
                            route: AppRoutes.namaKlinik,
                          ),
                          _buildMenuItem(
                            index: 5,
                            imagePath: 'assets/images/tempat_tidur.png',
                            title: 'Tempat Tidur\nTersedia',
                            route: AppRoutes.tempatTidur,
                          ),
                          _buildMenuItem(
                            index: 6,
                            imagePath: 'assets/images/farmasi.png',
                            title: 'Antrian\nFarmasi',
                            route: AppRoutes.antrianFarmasi,
                          ),
                          _buildMenuItem(
                            index: 7,
                            imagePath: 'assets/images/emergency.png',
                            title: 'Emergency',
                            route: AppRoutes.emergency,
                          ),
                        ];
                        return menuItems[index];
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ---------- PAKET LAYANAN (DIPERTAHANKAN dan DIKOREKSI) ----------
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
                    onPressed: () {
                      // Navigasi ke halaman "Lihat Semua Paket Layanan"
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
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
            // ListView horizontal untuk ServiceCard
            Obx(() {
              if (homeController.isLoadingLayanan.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (homeController.layananList.isEmpty) {
                return const Center(child: Text('Belum ada layanan tersedia.'));
              }
              // ⭐ Mengubah tinggi menjadi 180 untuk memberi ruang pada ServiceCard yang lebih tinggi
              return SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: homeController.layananList.length,
                  itemBuilder: (context, index) {
                    final layanan = homeController.layananList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16 : 0,
                        right: 12,
                      ),
                      child: ServiceCard(
                        title: layanan.nama,
                        subtitle: layanan.deskripsi,
                        imageUrl: layanan.fotoUtama,
                        price: layanan.harga,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),

      // ===================== FLOATING BOTTOM NAV (STYLE ASLI) =====================
      bottomNavigationBar: SlideTransition(
        position: _bottomNavSlide,
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              final items = [
                {'icon': Icons.home_rounded, 'label': 'Beranda'},
                {'icon': Icons.folder_shared_rounded, 'label': 'Riwayat RM'},
                {'icon': Icons.medical_services_rounded, 'label': 'Layanan'},
                {'icon': Icons.person_rounded, 'label': 'Akun'},
              ];

              final item = items[index];
              final isActive = _selectedBottomIndex == index;

              return GestureDetector(
                onTap: () {
                  if (!authController.isLoggedIn.value && index != 0) {
                    setState(() => _selectedBottomIndex = 0);
                    Get.snackbar(
                      'Perlu Login',
                      'Silakan login dulu untuk mengakses menu ini',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Get.toNamed(AppRoutes.login);
                  } else {
                    setState(() => _selectedBottomIndex = index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isActive ? Colors.blueAccent : Colors.grey,
                        size: isActive ? 28 : 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontFamily: 'LexendExa',
                          fontSize: 11,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? Colors.blueAccent : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // ===================== MENU ITEM + STAGGER ANIM =====================
  Widget _buildMenuItem({
    required int index,
    required String imagePath,
    required String title,
    required String route,
  }) {
    final delay = 80 * index;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: Transform.scale(
              scale: 0.9 + (value * 0.1),
              child: child,
            ),
          ),
        );
      },
      child: InkWell(
        onTap: () {
          if (authController.isLoggedIn.value) {
            Get.toNamed(route);
          } else {
            Get.snackbar(
              'Perlu Login',
              'Silakan login dulu untuk mengakses fitur ini',
              snackPosition: SnackPosition.BOTTOM,
            );
            Get.toNamed(AppRoutes.login);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(imagePath, width: 40, height: 40),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'LexendExa',
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
