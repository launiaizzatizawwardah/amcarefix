import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '/models/tempat_tidur_model.dart';

class TempatTidurController extends GetxController {
  final baseUrl = "http://172.16.24.137:8080/api";
  final box = GetStorage();

  RxList<TempatTidurModel> listBangsal = <TempatTidurModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBangsal();
  }

  Future<void> fetchBangsal() async {
    try {
      final token = box.read("token");

      final res = await http.get(
        Uri.parse("$baseUrl/tempat-tidur"),
        headers: {"Authorization": "Key $token"},
      );

      print("RAW TEMPAT TIDUR: ${res.body}");

      final jsonData = jsonDecode(res.body);
      final data = jsonData["data"] as List;

      listBangsal.value =
          data.map((e) => TempatTidurModel.fromJson(e)).toList();
    } catch (e) {
      print("ERROR FETCH TEMPAT TIDUR: $e");
    }
  }
}
