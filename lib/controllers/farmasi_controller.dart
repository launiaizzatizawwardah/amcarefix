import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FarmasiController extends GetxController {
  final box = GetStorage();
  final baseUrl = "http://172.16.24.137:8080/api";

  // 🔹 List data API
  var daftarFarmasi = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAntrianFarmasi();
  }

  // ============================================================
  // 🔥 Ambil Antrian Farmasi
  // ============================================================
  Future<void> fetchAntrianFarmasi() async {
    try {
      isLoading.value = true;

      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/antrian-farmasi"),
        headers: {
          "Authorization": "Key $token",
        },
      );

      print("FARMASI RAW: ${res.body}");

      if (res.body.isEmpty) return;

      final jsonData = jsonDecode(res.body);

      if (jsonData["status"] == "success") {
        daftarFarmasi.value = List<Map<String, dynamic>>.from(
          jsonData["data"].map((e) => {
                "nomor": e["nomor"] ?? "-",
                "no_cm": e["no_cm"] ?? "-",
                "racikan": e["racikan"] ?? "0",
                "tanggal": e["tanggal"] ?? "-",
              }),
        );
      }
    } catch (e) {
      print("🔥 ERROR FARMASI: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
