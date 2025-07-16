import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/new_parking.dart';
import 'package:parknet_pro/view/admin/single_parking_card.dart';

class ParkingMain extends StatelessWidget {
  const ParkingMain({super.key});

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
          "Parking Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SingleParkingCard(),
            const SizedBox(height: 10),
            SingleParkingCard(),
          ],
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Container(
      //     width: double.infinity,
      //     padding: const EdgeInsets.all(24),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(16),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.15),
      //           blurRadius: 12,
      //           offset: const Offset(0, 4),
      //         ),
      //       ],
      //     ),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(
      //           Icons.local_parking,
      //           size: 64,
      //           color: AppColors.primaryColor.withOpacity(0.3),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text(
      //           "No parking entries yet",
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //         ),
      //         const SizedBox(height: 8),
      //         Text(
      //           "Tap the + button to add your first parking location.",
      //           style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      //           textAlign: TextAlign.center,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NewParking());
        },
        backgroundColor: AppColors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
