import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/currently_parked/single_currently_parked_tile.dart';

class CurrentlyParked extends StatelessWidget {
  const CurrentlyParked({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    controller.fetchAllBookingsForAdmin();
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
          child: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
        ),
        title: const Text(
          "Currently Parked",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Obx(
        () {
          if (controller.getBookingForAdminLoading.isTrue) {
            return const Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (controller.bookingListForAdmin.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "No Booking Available",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 25),
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleCurrentlyParkedTile(index: index),
                      ),
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 0),
                  itemCount: controller.bookingListForAdmin.length,
                ),
              ),
            );
          }
        },

        // Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        // child: Column(
        //   children: [
        //     const SizedBox(height: 10),
        //     SingleCurrentlyParkedTile(),
        //     SingleCurrentlyParkedTile(),
        //   ],
        // ),
      ),
    );
  }
}
