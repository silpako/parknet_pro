import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/parking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/parkings/new_parking.dart';
import 'package:parknet_pro/view/admin/parkings/single_parking_card.dart';

class ParkingMain extends StatelessWidget {
  const ParkingMain({super.key});

  @override
  Widget build(BuildContext context) {
    final ParkingController controller = Get.put(ParkingController());
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

      body: Obx(() {
        if (controller.getParkingLoading.isTrue) {
          return const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (controller.parkingList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_parking, size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No Parkings Found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Click the + button to add a new parking slot.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.separated(
                itemBuilder:
                    (context, index) => SingleParkingCard(index: index),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: controller.parkingList.length,
              ),
            );
          }
        }
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NewParking());
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
