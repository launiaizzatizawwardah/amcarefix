class TempatTidurModel {
  final String namaRuang;
  final String kapasitas;
  final String tersedia;
  final String tgl;
  final String jam;
  final String? deskripsi;
  final String? gambar;

  TempatTidurModel({
    required this.namaRuang,
    required this.kapasitas,
    required this.tersedia,
    required this.tgl,
    required this.jam,
    this.deskripsi,
    this.gambar,
  });

  factory TempatTidurModel.fromJson(Map<String, dynamic> json) {
    return TempatTidurModel(
      namaRuang: json['nama_ruang'] ?? '-',
      kapasitas: json['kapasitas'] ?? '-',
      tersedia: json['tersedia'] ?? '-',
      tgl: json['tgl'] ?? '-',
      jam: json['jam'] ?? '-',
      deskripsi: json['deskripsi'] ?? "Tidak ada deskripsi",
      gambar: json['gambar'],
    );
  }
}
