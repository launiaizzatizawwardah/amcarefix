import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      final token = box.read("token");
      print("🔐 TOKEN DI DEVICE: $token");

      if (token != null && token.toString().isNotEmpty) {
        // SUDAH LOGIN → langsung ke HOME PRIVATE
        Get.offAllNamed(AppRoutes.home1);
      } else {
        // BELUM LOGIN → ke HOME PUBLIC
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// FULLSCREEN FIX — tampil penuh di semua device
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            /// LOGO
            Image.asset(
              'assets/images/logo_rs.png',
              width: 140,
              height: 140,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

            /// TITLE
            const Text(
              'AMCare',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontSize: 16,
              ),
            ),

            const Spacer(),

            /// VERSION
            const Text(
              'V 1.1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            /// POWERED BY
            const Text(
              'Powered by IT RS AMC Muhammadiyah',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
