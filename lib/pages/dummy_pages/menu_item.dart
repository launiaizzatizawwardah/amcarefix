import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final String route;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
    this.iconColor = const Color(0xFF284E7A),
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double scale = 1.0;
  double glow = 0.0;

  /// ANIMASI TAP
  void _onTap() async {
    setState(() {
      scale = 0.88;      // mengecil dulu
      glow = 16.0;       // glow aktif
    });

    await Future.delayed(const Duration(milliseconds: 120));

    setState(() {
      scale = 1.06;      // bounce
      glow = 0.0;
    });

    await Future.delayed(const Duration(milliseconds: 80));

    setState(() {
      scale = 1.0;       // normal
    });

    Get.toNamed(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(6),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.001),

          // Glow hanya aktif saat tap
          boxShadow: glow > 0
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.25),
                    blurRadius: glow,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),

        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutBack,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  size: 28,
                  color: widget.iconColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
