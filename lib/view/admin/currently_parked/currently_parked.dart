import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class CurrentlyParked extends StatelessWidget {
  const CurrentlyParked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        title: const Text(
          "Currently Parked",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
