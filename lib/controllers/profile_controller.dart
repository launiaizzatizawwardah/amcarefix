import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final box = GetStorage();
  final baseUrl = "http://172.16.24.137:8080/api";

  // DATA PROFIL AKTIF
  RxString nama = "".obs;
  RxString rm = "".obs;
  RxString alamat = "".obs;
  RxString tglLahir = "".obs;
  RxString sex = "".obs;
  RxString wa = "".obs;

  // LIST NOMOR PASIEN DARI API
  var pasienList = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // =====================================================
  // AMBIL PROFIL DULU → BARU AMBIL NOMOR PASIEN
  // =====================================================
  Future<void> loadData() async {
    await fetchProfile();       
    await fetchNomorPasien();   
  }

  // =====================================================
  // 1) API /me → DATA DIRI
  // =====================================================
  Future<void> fetchProfile() async {
    try {
      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/me"),
        headers: {
          "Authorization": "Key $token",
        },
      );

      print("PROFILE: ${res.body}");

      final body = jsonDecode(res.body);

      if (body["status"] != "success") {
        print("❌ Gagal dapat data profile");
        return;
      }

      final data = body["data"];

      nama.value = data["nama_pas"];
      rm.value = data["no_cm"];
      alamat.value = data["alamat"];
      tglLahir.value = data["tgl_lahir"];
      sex.value = data["sex"];
      wa.value = data["telp"]; 

      print("WA untuk nomor-pasien: ${wa.value}");
    } catch (e) {
      print("ERROR PROFILE: $e");
    }
  }

  // =====================================================
  // 2) API /nomor-pasien → POST + RAW JSON (WAJIB!)
  // =====================================================
  Future<void> fetchNomorPasien() async {
  try {
    final token = box.read("token");

    final url = Uri.parse("$baseUrl/nomor-pasien");

    // Request manual seperti Postman
    final req = http.Request("GET", url);
    req.headers.addAll({
      "Authorization": "Key $token",
      "Content-Type": "application/json",
    });

    req.body = jsonEncode({
      "nomor": wa.value,
    });

    print(">>> REQUEST BODY: ${req.body}");

    final streamed = await req.send();
    final res = await http.Response.fromStream(streamed);

    print("NOMOR PASIEN RAW: ${res.body}");

    if (res.body.isEmpty) {
      print("⚠️ Backend membalas kosong");
      return;
    }

    final json = jsonDecode(res.body);

    pasienList.value =
        List<Map<String, dynamic>>.from(json["data"]);

    print("LIST PASIEN: $pasienList");

  } catch (e) {
    print("ERROR NOMOR PASIEN: $e");
  }
}


  // =====================================================
  // 3) SWITCH RM (GAYA INSTAGRAM)
  // =====================================================
  void pilihRM(Map<String, dynamic> p) {
    nama.value = p["nama_pas"];
    rm.value = p["no_cm"];
  }
}
