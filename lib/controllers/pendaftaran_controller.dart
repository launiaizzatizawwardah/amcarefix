import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/pages/widget/dialog_success.dart'; // pastikan path ini sesuai
import '/routes/app_routes.dart'; // ✅ untuk AppRoutes.home1

class PendaftaranController extends GetxController {
  var selectedPasien = ''.obs;
  var tanggal = Rxn<DateTime>();
  var poli = ''.obs;
  var dokter = ''.obs;
  var kuota = 0.obs;

  // 🔹 Data pasien gabung nama + RM
  final pasienList = [
    {'nama': 'Launia Izzati', 'rm': '101523789'},
    {'nama': 'Dewi Anggraini', 'rm': '101523790'},
    {'nama': 'Rizky Pratama', 'rm': '101523791'},
  ];

  // 🔹 Data Poli & Dokter (lokal)
  final poliList = ['IPD', 'Anak', 'Gigi', 'Umum'];

  final dokterMap = {
    'IPD': [
      {'nama': 'dr. Joko, ST', 'jam': '08.00 - 12.00', 'kuota': 8},
      {'nama': 'dr. Rina, SpA', 'jam': '13.00 - 16.00', 'kuota': 5},
    ],
    'Anak': [
      {'nama': 'dr. Budi, SpA', 'jam': '09.00 - 12.00', 'kuota': 10},
    ],
    'Gigi': [
      {'nama': 'drg. Sinta', 'jam': '08.00 - 14.00', 'kuota': 7},
    ],
    'Umum': [
      {'nama': 'dr. Andi', 'jam': '07.00 - 11.00', 'kuota': 4},
    ],
  };

  // Getter dinamis dokter berdasarkan poli
  List<Map<String, dynamic>> get dokterList => dokterMap[poli.value] ?? [];

  // 🔹 Ketika user pilih dokter, cari kuota-nya
  void pilihDokter(String? namaDokter) {
    dokter.value = namaDokter ?? '';
    if (dokter.value.isNotEmpty) {
      final data = dokterList.firstWhere(
        (d) => d['nama'] == dokter.value,
        orElse: () => {'kuota': 0},
      );
      kuota.value = data['kuota'] ?? 0;
    } else {
      kuota.value = 0;
    }
  }

  // 🔹 Pilih tanggal periksa
  void pilihTanggal(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: tanggal.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) tanggal.value = picked;
  }

  // 🔹 Validasi dan submit form
  void submitForm(BuildContext context) {
    if (selectedPasien.isEmpty ||
        tanggal.value == null ||
        poli.isEmpty ||
        dokter.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Mohon lengkapi semua data!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else if (kuota.value <= 0) {
      Get.snackbar(
        'Kuota Habis',
        'Kuota untuk dokter ini sudah penuh!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      // ✅ Tampilkan popup sukses
      showSuccessDialog(context, selectedPasien.value);
    }
  }
}
