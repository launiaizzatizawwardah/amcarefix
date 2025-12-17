import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = const Color(0xFF2E8BC0);
  static Color background = const Color(0xFFF7FAFF);

  static BoxDecoration glassBox = BoxDecoration(
    color: Colors.white.withOpacity(0.25),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.4)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static LinearGradient softBlueGradient = const LinearGradient(
    colors: [
      Color(0xFFd8eafd),
      Color(0xFFfafdff),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
