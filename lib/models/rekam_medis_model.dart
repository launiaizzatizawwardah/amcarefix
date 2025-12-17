class RekamMedisItem {
  final String tanggal;
  final String poli;
  final String dokter;
  final String diagnosa;

  RekamMedisItem({
    required this.tanggal,
    required this.poli,
    required this.dokter,
    required this.diagnosa,
  });

  factory RekamMedisItem.fromJson(Map<String, dynamic> json) {
    return RekamMedisItem(
      tanggal: json["tanggal"] ?? "-",
      poli: json["poli"] ?? "-",
      dokter: json["dokter"] ?? "-",
      diagnosa: json["diagnosa"] ?? "-",
    );
  }
}
