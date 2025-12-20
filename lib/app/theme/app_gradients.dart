import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [
      Color(0xFF0072FF), // Blue
      Color(0xFF884DFF), // Purple
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient card1 = LinearGradient(
    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Purple to Blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient card2 = LinearGradient(
    colors: [Color(0xFF00c6ff), Color(0xFF0072ff)], // Blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient card3 = LinearGradient(
    colors: [Color(0xFFfe8c00), Color(0xFFf83600)], // Orange
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // List to easily pick a gradient
  static const List<LinearGradient> cardGradients = [card1, card2, card3];
}
