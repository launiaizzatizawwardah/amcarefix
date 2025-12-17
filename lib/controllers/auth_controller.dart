import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    // 🔥 CEK TOKEN SAAT APP DIBUKA
    final token = box.read("token");
    if (token != null && token.toString().isNotEmpty) {
      isLoggedIn.value = true;
      print("✅ AUTO LOGIN: TOKEN DITEMUKAN");
    } else {
      print("❌ BELUM LOGIN");
    }
  }

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
    box.remove("token"); // hapus token saat logout
  }
}
