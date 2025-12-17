class DokterModel {
  final String namaDokter;
  final String namaPoli;
  final Map<String, String> jadwal;

  DokterModel({
    required this.namaDokter,
    required this.namaPoli,
    required this.jadwal,
  });

  factory DokterModel.fromJson(Map<String, dynamic> json) {
    return DokterModel(
      namaDokter: json["nama"] ?? "-",
      namaPoli: json["nama_poli"] ?? "-",
      jadwal: {
        "senin": json["senin"] ?? "-",
        "selasa": json["selasa"] ?? "-",
        "rabu": json["rabu"] ?? "-",
        "kamis": json["kamis"] ?? "-",
        "jumat": json["jumat"] ?? "-",
        "sabtu": json["sabtu"] ?? "-",
        "minggu": json["minggu"] ?? "-",
      },
    );
  }
}
