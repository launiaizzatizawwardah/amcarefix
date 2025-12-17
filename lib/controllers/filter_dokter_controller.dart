import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/dokter_model.dart';

class FilterDokterController extends GetxController {
  final baseUrl = "http://172.16.24.49:7100/api";
  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxList<DokterModel> filteredList = <DokterModel>[].obs;

  // 🔥 Ambil dokter khusus 1 poli
  Future<void> fetchDokterByPoli(String poli) async {
    try {
      isLoading.value = true;

      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/poli-dokter"),
        headers: {"Authorization": "Key $token"},
      );

      final json = jsonDecode(res.body);
      final List data = json["data"] ?? [];

      // mapping ke model
      final allDokter =
          data.map((e) => DokterModel.fromJson(e as Map<String, dynamic>))
              .toList();

      // filter berdasarkan nama_poli persis dari API
      filteredList.value =
          allDokter.where((d) => d.namaPoli == poli).toList();

      print("🔎 FILTER POLI: $poli");
      print("✅ JUMLAH DOKTER HASIL FILTER: ${filteredList.length}");
    } catch (e) {
      print("⚠ ERROR FETCH DOKTER BY POLI: $e");
      filteredList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
