import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/rekam_medis_model.dart';

class RiwayatController extends GetxController {
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

      // 👉 sementara hardcode dulu, nanti bisa diambil dari data login
      const nomor = "62895343023218";
      const norm = "10027878";

      final url = Uri.parse("http://172.16.24.137:8080/api/pasien-diagnosa");

      // ❗ server kamu pakai GET + body (sesuai Postman)
      final request = http.Request('GET', url);
     request.headers.addAll({
  "Authorization": "Key 4caca6ff11b8500c4bf85706ba1c117f16c13a708053b06d74f5aa55186e4c2d",
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
            data.map((item) => RekamMedisItem.fromJson(item)).toList();
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
