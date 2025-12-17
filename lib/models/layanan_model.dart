class Layanan {
  final String nama;
  final String fotoUtama;
  final String harga;
  final String deskripsi;

  Layanan({
    required this.nama,
    required this.fotoUtama,
    required this.harga,
    required this.deskripsi,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    final foto = json['foto_utama'] ?? '';
    final fotoUrl = foto.isNotEmpty
        ? 'https://admin.rsamcmuhammadiyah.com/assets/uploads/layanan/utama/$foto'
        : '';

    return Layanan(
      nama: json['nama'] ?? '',
      fotoUtama: fotoUrl,
      harga: json['harga']?.toString() ?? '0',
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}
