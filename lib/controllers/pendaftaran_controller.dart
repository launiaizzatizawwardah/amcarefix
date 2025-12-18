import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/pages/widget/dialog_success.dart';

class PendaftaranController extends GetxController {
  final box = GetStorage();
  final baseUrl = "http://172.16.24.49:7100/api";

  // ================= STATE =================
  var isLoading = false.obs;

  var selectedPasien = ''.obs; // RM
  var tanggal = Rxn<DateTime>();
  var poli = ''.obs;
  var dokter = ''.obs;
  var kuota = 0.obs;

  // ================= DATA API =================
  final pasienList = <Map<String, String>>[].obs;
  final poliList = <String>[].obs;
  final dokterList = <Map<String, dynamic>>[].obs;

  // ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchPoli();
  }

  // =================================================
  // 🔥 FETCH PROFILE / PASIEN
  // =================================================
  Future<void> fetchProfile() async {
    try {
      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/profile"),
        headers: {"Authorization": "Key $token"},
      );

      final json = jsonDecode(res.body);
      final data = json["data"] as List;

      pasienList.value = data.map((p) => {
        "nama": p["nama"].toString(),
        "rm": p["rm"].toString(),
      }).toList();

    } catch (e) {
      print("ERROR PROFILE: $e");
    }
  }

  // =================================================
  // 🔥 FETCH POLI / KLINIK
  // =================================================
  Future<void> fetchPoli() async {
    try {
      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/poli"),
        headers: {"Authorization": "Key $token"},
      );

      final json = jsonDecode(res.body);
      final data = json["data"] as List;

      poliList.value =
          data.map((p) => p["nama_poli"].toString()).toList();

    } catch (e) {
      print("ERROR POLI: $e");
    }
  }

  // =================================================
  // 🔥 FETCH DOKTER BY POLI + TANGGAL
  // =================================================
  Future<void> fetchDokter() async {
    if (poli.isEmpty || tanggal.value == null) return;

    try {
      isLoading.value = true;
      final token = box.read("token");

      final res = await http.get(
        Uri.parse(
          "$baseUrl/poli-dokter?"
          "poli=${poli.value}&"
          "tanggal=${tanggal.value!.toIso8601String()}",
        ),
        headers: {"Authorization": "Key $token"},
      );

      final json = jsonDecode(res.body);
      dokterList.value =
          List<Map<String, dynamic>>.from(json["data"]);

    } catch (e) {
      print("ERROR DOKTER: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // =================================================
  // 🔥 PILIH DOKTER
  // =================================================
  void pilihDokter(String? namaDokter) {
    dokter.value = namaDokter ?? '';

    final data = dokterList.firstWhere(
      (d) => d["nama_dokter"] == dokter.value,
      orElse: () => {"kuota": 0},
    );

    kuota.value = data["kuota"] ?? 0;
  }

  // =================================================
  // 🔥 PILIH TANGGAL
  // =================================================
  void pilihTanggal(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: tanggal.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      tanggal.value = picked;
      fetchDokter(); // 🔥 otomatis refresh dokter
    }
  }

  // =================================================
  // 🔥 SUBMIT PENDAFTARAN (REAL API)
  // =================================================
  Future<void> submitForm(BuildContext context) async {
    if (selectedPasien.isEmpty ||
        tanggal.value == null ||
        poli.isEmpty ||
        dokter.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Mohon lengkapi semua data!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (kuota.value <= 0) {
      Get.snackbar(
        'Kuota Habis',
        'Kuota untuk dokter ini sudah penuh!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final token = box.read("token");

      final res = await http.post(
        Uri.parse("$baseUrl/pendaftaran"),
        headers: {
          "Authorization": "Key $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "rm": selectedPasien.value,
          "tanggal": tanggal.value!.toIso8601String(),
          "poli": poli.value,
          "dokter": dokter.value,
        }),
      );

      if (res.statusCode == 200) {
        showSuccessDialog(context, selectedPasien.value);
      } else {
        Get.snackbar("Gagal", "Pendaftaran gagal");
      }

    } catch (e) {
      print("ERROR SUBMIT: $e");
    }
  }
}
