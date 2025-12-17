import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://172.16.24.137:8080/api/pasien-diagnosa";

  static Future<List<dynamic>> getRiwayatMedis() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData["data"] ?? [];
    } else {
      return [];
    }
  }
}
