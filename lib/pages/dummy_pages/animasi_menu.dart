import 'package:flutter/material.dart';

class MenuAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const MenuAnimation({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<MenuAnimation> createState() => _MenuAnimationState();
}

class _MenuAnimationState extends State<MenuAnimation> {
  double scale = 1.0;

  Future<void> playAnimation() async {
    setState(() => scale = 0.88);
    await Future.delayed(const Duration(milliseconds: 90));

    setState(() => scale = 1.15);
    await Future.delayed(const Duration(milliseconds: 120));

    setState(() => scale = 1.0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.88),
      onTapUp: (_) => playAnimation(),
      onTapCancel: () => setState(() => scale = 1.0),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}
