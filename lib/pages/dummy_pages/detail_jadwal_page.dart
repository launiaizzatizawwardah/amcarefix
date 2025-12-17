import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/poliklinik_model.dart';

class DetailJadwalPage extends StatelessWidget {
  final Poliklinik dokter = Get.arguments;

  DetailJadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal ${dokter.namaDokter}'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dokter.jadwal.entries.map((e) {
            final hari = e.key;
            final jam = e.value.join(', ');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text('$hari: $jam', style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
