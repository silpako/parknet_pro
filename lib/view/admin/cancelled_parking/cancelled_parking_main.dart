import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/cancelled_parking/single_cancelled_parking_tile.dart';

class CancelledParkingMain extends StatelessWidget {
  const CancelledParkingMain({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    controller.fetchAllCancelledBookingsForAdmin();

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
          "Cancelled Parking",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() {
          if (controller.getCancelledBookingForAdminLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final cancelled = controller.cancelledBookingListForAdmin;
          if (cancelled.isEmpty) {
            return const Center(child: Text("No cancelled bookings found."));
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return SingleCancelledParkingTile(index: index);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: cancelled.length,
          );
        }),
      ),
    );
  }
}
