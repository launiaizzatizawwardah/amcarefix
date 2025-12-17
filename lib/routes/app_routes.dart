import 'package:get/get.dart';

// 🏠 Main Pages
import '../pages/home_page.dart';
import '../pages/dummy_pages/home_page1.dart';

// 🔐 Auth
import '../pages/dummy_pages/login_page.dart';
import '../pages/dummy_pages/otp_verification_page.dart';

// 📄 Pages
import '../pages/dummy_pages/pendaftaran_online_page.dart';
import '../pages/dummy_pages/riwayat_rekam_medis_page.dart';
import '../pages/dummy_pages/riwayat_rekam_medis_page1.dart';
import '../pages/dummy_pages/pemantauan_antrian_page.dart';
import '../pages/dummy_pages/jadwal_dokter_page.dart';
import '../pages/dummy_pages/nama_klinik_page.dart';
import '../pages/dummy_pages/tempat_tidur_page.dart';
import '../pages/dummy_pages/detail_tempat_tidur_page.dart';
import '../pages/dummy_pages/antrian_farmasi_page.dart';
import '../pages/dummy_pages/emergency_page.dart';
import '../pages/dummy_pages/jadwal_dokter_filter_page.dart';

// Detail
import '../pages/dummy_pages/detail_jadwal_page.dart';

// Splash
import '../pages/splash_page.dart';

// Profile
import '../pages/dummy_pages/profile_page.dart';
import '../pages/dummy_pages/edit_profile_page.dart';

class AppRoutes {
  static const splash = '/';

  // Auth
  static const login = '/login';
  static const otpVerification = '/otp_verification';

  // Home
  static const home = '/home';
  static const home1 = '/home1';

  // Menu
  static const pendaftaranOnline = '/pendaftaran_online';
  static const riwayatRekamMedis = '/riwayat_rekam_medis';
  static const riwayatRekamMedis1 = '/riwayat_rekam_medis1';
  static const pemantauanAntrian = '/pemantauan_antrian';
  static const jadwalDokter = '/jadwal_dokter';
  static const detailJadwal = '/detail-jadwal';
  static const namaKlinik = '/nama_klinik';

  // Tempat Tidur
  static const tempatTidur = '/tempat_tidur';
  static const detailTempatTidur = '/detail-tempat-tidur';

  //filter dokter
 
  static const jadwalDokterFilter = '/jadwal_dokter_filter'; // 🔥 route baru

  // Farmasi
  static const antrianFarmasi = '/antrian_farmasi';

  // Emergency
  static const emergency = '/emergency';

  // Profil
  static const profile = '/profile';
  static const editProfile = '/edit_profile';

  static final routes = [
    // Splash
    GetPage(name: splash, page: () => const SplashPage()),

    // Auth
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: otpVerification, page: () => OTPVerificationPage()),

    // Home
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: home1, page: () => const HomePage1()),

    // Menu
    GetPage(name: pendaftaranOnline, page: () => const PendaftaranOnlinePage()),

    // Riwayat
    GetPage(name: riwayatRekamMedis, page: () =>  RiwayatRekamMedisPage()),
    GetPage(name: riwayatRekamMedis1, page: () =>  RiwayatRekamMedisPage1()),

    // Antrian & Jadwal
    GetPage(name: pemantauanAntrian, page: () => const PemantauanAntrianPage()),
    GetPage(name: jadwalDokter, page: () => JadwalDokterPage()),
    GetPage(name: detailJadwal, page: () => DetailJadwalPage()),

    //filter dokter
    GetPage(name: jadwalDokterFilter, page: () => JadwalDokterFilterPage()),


    // Klinik
    GetPage(name: namaKlinik, page: () => NamaPoliklinikPage()),

    // Tempat Tidur (PASTIKAN TIDAK ADA CONST!)
    GetPage(name: tempatTidur, page: () => TempatTidurPage()),
    GetPage(name: detailTempatTidur, page: () => DetailTempatTidurPage()),

    // Farmasi
    GetPage(name: antrianFarmasi, page: () => const AntrianFarmasiPage()),

    // Emergency
    GetPage(name: emergency, page: () => const EmergencyPage()),

    // Profile
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: editProfile, page: () => EditProfilePage()),
  ];
}
