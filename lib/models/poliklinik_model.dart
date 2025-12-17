class Poliklinik {
  final String namaPoli;
  final String namaDokter;
  final Map<String, List<String>> jadwal;

  Poliklinik({
    required this.namaPoli,
    required this.namaDokter,
    required this.jadwal,
  });
}
