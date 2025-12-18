import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/rekam_medis_model.dart';

class RiwayatController extends GetxController {
  final box = GetStorage();

  var isLoading = true.obs;
  var riwayat = <RekamMedisItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRiwayat();
  }

  Future<void> fetchRiwayat() async {
    try {
      isLoading.value = true;

      // ✅ AMBIL DATA DARI STORAGE
      final String? token = box.read('token');
      final String? nomor = box.read('nomor');
      final String? norm = box.read('norm');

      // ❗ Validasi
      if (token == null || nomor == null || norm == null) {
        print("DATA LOGIN TIDAK LENGKAP");
        return;
      }

      final url = Uri.parse(
        "http://172.16.24.137:8080/api/pasien-diagnosa",
      );

      final request = http.Request('GET', url);

      request.headers.addAll({
        "Authorization": "Key $token",
        "Content-Type": "application/json",
      });

      request.body = jsonEncode({
        "nomor": nomor,
        "norm": norm,
      });

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List data = json["data"] ?? [];

        riwayat.value =
            data.map((e) => RekamMedisItem.fromJson(e)).toList();
      } else {
        riwayat.clear();
      }
    } catch (e) {
      print("ERROR FETCH RIWAYAT: $e");
      riwayat.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
