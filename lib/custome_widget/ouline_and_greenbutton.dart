import 'package:flutter/material.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GreenButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String text;
  final Widget image;
  final VoidCallback onPressed;

  const BorderButton({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.black, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          image,
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 16)),
        ],
      ),
    );
  }
}
