import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:intl/intl.dart';

class SingleCancelledParkingTile extends StatelessWidget {
  final int index;
  const SingleCancelledParkingTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    final bookings = controller.cancelledBookingListForAdmin[index];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black12,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cancel, color: AppColors.red, size: 26),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookings['vehicleNumber'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${bookings['parkingName'] ?? ''}",
                    style: const TextStyle(fontSize: 13, color: AppColors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Started at: ${bookings['slotTime'] ?? ''}",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Cancelled on: ${DateFormat('dd MMM yyyy').format((bookings['bookingDate'] as Timestamp).toDate())}",
                    style: const TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: const [
                Icon(Icons.error_outline, color: AppColors.red, size: 22),
                SizedBox(height: 4),
                Text(
                  "Cancelled",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
