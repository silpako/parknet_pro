import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.getBookingLoading.isTrue) {
          return const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (controller.bookingList.isEmpty) {
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
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.bookingList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final booking = controller.bookingList[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🅿️ Parking Name & Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking['parkingName'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          _buildStatusChip(booking['status'] ?? ''),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // 📅 Booking Info Rows
                      _buildInfoRow(
                        Icons.calendar_today,
                        "Date",
                        DateFormat('dd MMM yyyy').format(
                          (booking['bookingDate'] as Timestamp).toDate(),
                        ),
                      ),

                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.access_time,
                        "Slot",
                        booking['slotTime'] ?? '',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.directions_car,
                        "Vehicle",
                        booking['vehicleNumber'] ?? '',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.currency_rupee,
                        "Amount",
                        "${booking['totalAmount']}",
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
      }),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.blue;
        label = "Active";
        break;
      case 'completed':
        color = Colors.green;
        label = "Completed";
        break;
      case 'cancelled':
        color = Colors.red;
        label = "Cancelled";
        break;
      default:
        color = Colors.grey;
        label = "Unknown";
    }

    return Chip(
      backgroundColor: color.withOpacity(0.1),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
