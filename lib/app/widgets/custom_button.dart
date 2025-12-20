import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
      foregroundColor: Colors.white,
      side: isPrimary
          ? BorderSide.none
          : const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
