import 'package:get/get.dart';

class DokterController extends GetxController {
  var selectedDokter = ''.obs;

  final List<Map<String, String>> dokterList = [
    {'nama': 'dr. Ahmad Fauzi', 'jam': '08.00 - 12.00'},
    {'nama': 'dr. Siti Aisyah', 'jam': '13.00 - 16.00'},
    {'nama': 'dr. Budi Hartono', 'jam': '17.00 - 20.00'},
  ];
}
