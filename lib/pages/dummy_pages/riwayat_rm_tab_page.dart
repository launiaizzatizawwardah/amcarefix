import 'package:flutter/material.dart';

class RiwayatRMTabPage extends StatelessWidget {
  const RiwayatRMTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Riwayat Rekam Medis",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'LexendExa',
          ),
        ),
      ),
    );
  }
}