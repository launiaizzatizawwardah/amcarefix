import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuCard extends StatefulWidget {
  final String img;
  final String title;
  final String route;

  const MenuCard({
    super.key,
    required this.img,
    required this.title,
    required this.route,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  double scale = 1.0;
  double glow = 0.0;

  void _animateTap() async {
    setState(() {
      scale = 0.88;    // mengecil
      glow = 18.0;     // glow aktif
    });

    await Future.delayed(const Duration(milliseconds: 120));

    setState(() {
      scale = 1.05;    // bounce
      glow = 0.0;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      scale = 1.0;     // normal
    });

    Get.toNamed(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,

        // ⚠️ WAJIB ADA BIAR ANIMASI KELIATAN!
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.01), // super transparan, tidak mengubah UI

          // GLOW sekarang pasti terlihat
          boxShadow: glow > 0
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.28),
                    blurRadius: glow,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),

        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.img, width: 42, height: 42),
              const SizedBox(height: 10),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'LexendExa',
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
