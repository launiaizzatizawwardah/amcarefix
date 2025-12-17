class SliderModel {
  final String nama;
  final String foto;
  final String slug;

  SliderModel({
    required this.nama,
    required this.foto,
    required this.slug,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    final foto = json['foto'] ?? '';
    final fotoUrl = foto.isNotEmpty
        ? 'https://admin.rsamcmuhammadiyah.com/assets/uploads/slider/$foto'
        : '';
    return SliderModel(
      nama: json['nama'] ?? '',
      foto: fotoUrl,
      slug: json['slug'] ?? '',
    );
  }
}
