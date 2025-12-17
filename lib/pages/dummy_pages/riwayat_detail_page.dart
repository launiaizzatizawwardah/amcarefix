import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/rekam_medis_model.dart';

class DetailRiwayatRekamMedis extends StatelessWidget {
  final RekamMedisItem data;

  const DetailRiwayatRekamMedis({super.key, required this.data});

  Widget buildInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label,
              style: const TextStyle(fontFamily: 'LexendExa', fontSize: 12)),
        ),
        const Text(" : ",
            style: TextStyle(fontFamily: 'LexendExa', fontSize: 12)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontFamily: 'LexendExa', fontSize: 12)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.tanggal,
                    style: const TextStyle(
                        fontFamily: 'LexendExa',
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),

                const SizedBox(height: 6),

                Text(data.poli,
                    style: const TextStyle(
                        fontFamily: 'LexendExa',
                        fontSize: 14,
                        color: Colors.black87)),

                const SizedBox(height: 4),

                Text(data.dokter,
                    style: const TextStyle(
                        fontFamily: 'LexendExa',
                        fontSize: 12,
                        color: Colors.black54)),

                const SizedBox(height: 12),
                const Divider(),

                const Text("Keluhan & Diagnosa",
                    style: TextStyle(
                      fontFamily: 'LexendExa',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),

                const SizedBox(height: 8),

                // buildInfo("Keluhan", data.keluhan),
                buildInfo("Diagnosa", data.diagnosa),

                const SizedBox(height: 10),
              ],
            ),
          ),

          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Get.back(),
            ),
          )
        ],
      ),
    );
  }
}
