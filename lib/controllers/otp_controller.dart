import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '/routes/app_routes.dart';
import 'auth_controller.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var isResending = false.obs;

  final baseUrl = 'http://172.16.24.137:8080/api';

  final box = GetStorage();

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "*/*",
      };

  // ============================================================
  // 1) KIRIM OTP
  // ============================================================
  Future<void> sendOtp(String nik) async {
    try {
      isLoading.value = true;

      final url = Uri.parse('$baseUrl/otp');
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"nik": nik.trim()}),
      );

      print("📥 SEND OTP RESPONSE: ${response.body}");
      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        Get.toNamed(AppRoutes.otpVerification, arguments: {"nik": nik});
      } else {
        Get.snackbar("Gagal", data["message"] ?? "Gagal mengirim OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // 2) VERIFIKASI OTP + SIMPAN TOKEN + UPDATE LOGIN STATUS
  // ============================================================
  Future<void> verifyOtp({
    required String nik,
    required String otp,
  }) async {
    if (otp.length != 6) {
      Get.snackbar("OTP tidak lengkap", "Masukkan 6 digit OTP");
      return;
    }

    try {
      isLoading.value = true;

      final url = Uri.parse('$baseUrl/verify-otp');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          "nik": nik.trim(),
          "otp": otp, 
          "uuid": "value",
          "ipaddress": "192.16.23.1",
        }),
      );

      print("📥 VERIFY RAW: ${response.body}");
      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        // AMBIL sesson_key DARI BACKEND (perhatikan typo!)
        final sessionKey = data["data"]?["sesson_key"];

        print("SESSION KEY: $sessionKey");

        if (sessionKey != null) {
          // SIMPAN TOKEN
          box.write("token", sessionKey);
          print("🔐 TOKEN DISIMPAN: ${box.read("token")}");

          // UPDATE STATUS LOGIN
          Get.find<AuthController>().isLoggedIn.value = true;
        }

        // MASUK KE HOME PRIVATE
        Get.offAllNamed(AppRoutes.home1);
      } else {
        Get.snackbar("OTP Salah", data["message"] ?? "Kode OTP salah");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // 3) KIRIM ULANG OTP
  // ============================================================
  Future<void> resendOtp(String nik) async {
    try {
      isResending.value = true;

      final url = Uri.parse('$baseUrl/otp');

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({"nik": nik.trim()}),
      );

      print("📥 RESEND OTP RESPONSE: ${response.body}");

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        Get.snackbar("Sukses", "OTP baru berhasil dikirim");
      } else {
        Get.snackbar("Gagal", data["message"] ?? "Gagal kirim ulang OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isResending.value = false;
    }
  }
}
