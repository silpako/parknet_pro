import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, String message) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 3),
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        position: FlashPosition.bottom,
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  );
}
