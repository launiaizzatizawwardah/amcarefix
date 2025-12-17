import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class GlassMenuItem extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const GlassMenuItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  State<GlassMenuItem> createState() => _GlassMenuItemState();
}

class _GlassMenuItemState extends State<GlassMenuItem> {
  double scale = 1.0;

  void animate() async {
    setState(() => scale = 1.12);
    await Future.delayed(const Duration(milliseconds: 140));

    setState(() => scale = 1.0);

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOutQuad,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: animate,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: AppTheme.glassBox,
          child: Column(
            children: [
              Image.asset(widget.image, width: 42),
              const SizedBox(height: 8),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
