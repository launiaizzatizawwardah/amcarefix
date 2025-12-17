import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/tempat_tidur_model.dart';

class DetailTempatTidurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TempatTidurModel item = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8BC0),
        title: const Text(
          "Detail Tempat Tidur",
          style: TextStyle(fontFamily: 'LexendExa'),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
                image: item.gambar != null
                    ? DecorationImage(
                        image: NetworkImage(item.gambar!),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage("assets/images/default-room.jpg"),
                        fit: BoxFit.cover),
              ),
            ),

            Text(
              item.namaRuang,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'LexendExa',
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E8BC0),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                item.deskripsi ?? "Tidak ada deskripsi",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: 'LexendExa',
                ),
              ),
            ),

            const SizedBox(height: 20),

            _infoCard("Kapasitas", item.kapasitas),
            _infoCard("Tersedia", item.tersedia),
            _infoCard("Tanggal Update", item.tgl),
            _infoCard("Jam Update", item.jam),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                color: Colors.black54,
              )),
          Text(value,
              style: const TextStyle(
                fontFamily: 'LexendExa',
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E8BC0),
              )),
        ],
      ),
    );
  }
}
