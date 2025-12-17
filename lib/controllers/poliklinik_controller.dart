import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/dokter_model.dart';

class PoliklinikController extends GetxController {
  final baseUrl = "http://172.16.24.49:7100/api";
  final box = GetStorage();

  RxBool isLoading = false.obs;

  RxList<DokterModel> dokterList = <DokterModel>[].obs;
  RxList<DokterModel> filteredList = <DokterModel>[].obs;

  // =============================================================
  // 🔥 MAPPING PENAMAAN POLI UI -> API
  // =============================================================
  final Map<String, String> poliMapping = {
    "Klinik Penyakit Dalam": "Penyakit Dalam",
    "Klinik Jantung": "Jantung & Pembuluh Darah",
    "Klinik Kulit & Kelamin": "Kulit & Kelamin",
    "Klinik Kebidanan & Kandungan": "Kebidanan & Kandungan",
    "Klinik Anak": "Anak",
    "Klinik Mata": "Mata",
    "Klinik Neurologi": "Neurologi (Syaraf)",
    "Klinik Psikiatri": "Psikiatri",
    "Klinik THT": "THT",
    "Klinik Orthopaedi": "Orthopaedi",
    "Klinik Paru": "Paru",
    "Klinik Bedah": "Bedah",
    "Klinik Bedah Anak": "Bedah Anak",
    "Klinik Gigi": "Gigi Umum",
    "Klinik Umum": "Klinik Umum",
  };

  @override
  void onInit() {
    super.onInit();
    fetchDokter();
  }

  // =========================================================
  // 🔥 FETCH DOKTER
  // =========================================================
  Future<void> fetchDokter() async {
    try {
      isLoading.value = true;

      final token = box.read("token");
      final res = await http.get(
        Uri.parse("$baseUrl/poli-dokter"),
        headers: {"Authorization": "Key $token"},
      );

      final json = jsonDecode(res.body);
      final data = json["data"] as List;

      dokterList.value =
          data.map((e) => DokterModel.fromJson(e)).toList();

      filteredList.value = dokterList;

    } catch (e) {
      print("ERROR FETCH DOKTER: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // 🔍 FILTER SEARCH
  // =========================================================
  void searchPoliklinik(String keyword) {
    keyword = keyword.toLowerCase();

    filteredList.value = dokterList.where((d) {
      return d.namaDokter.toLowerCase().contains(keyword) ||
          d.namaPoli.toLowerCase().contains(keyword);
    }).toList();
  }

  // =========================================================
  // 🔥 FILTER BY KLINIK — FIXED 100% WORK
  // =========================================================
  void filterByKlinik(String selectedPoliUI) {
    // CARI POLI API YANG SESUAI
    final poliAPI = poliMapping[selectedPoliUI] ?? selectedPoliUI;

    print("🔍 FILTER MASUKAN UI  = $selectedPoliUI");
    print("🔍 DIPETAKAN KE API   = $poliAPI");

    filteredList.value = dokterList.where((d) {
      return d.namaPoli.toLowerCase() == poliAPI.toLowerCase();
    }).toList();

    print("Hasil filter: ${filteredList.length} dokter");
  }
}
