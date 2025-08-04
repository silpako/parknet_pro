import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:parknet_pro/error_response/error_message.dart';
import 'package:parknet_pro/error_response/success_message.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';

class BookingController extends GetxController {
  RxInt days = 1.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final int pricePerDay = 50;
  RxInt totalPrice = 50.obs;
  RxBool isLoading = false.obs;
  final firebaseFunctions = FirebaseFunctions();

  void increaseDays() {
    days.value++;
    updateTotalPrice();
  }

  void decreaseDays() {
    if (days.value > 1) {
      days.value--;
      updateTotalPrice();
    }
  }

  void resetDays() {
    days.value = 1;
    updateTotalPrice();
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateTotalPrice() {
    totalPrice.value = pricePerDay * days.value;
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      setDate(picked);
    }
  }

  Future<void> bookParking(
    BuildContext context,
    parkingId,
    parkingName,
    slotTime,
    totalDays,
    vehicleNumber,
    totalAmount,
  ) async {
    try {
      isLoading(true);

      final result = await firebaseFunctions.bookParking(
        parkingId: parkingId,
        parkingName: parkingName,
        slotTime: slotTime,
        totalDays: totalDays,
        vehicleNumber: vehicleNumber,
        totalAmount: totalAmount,
      );

      if (result == null) {
        if (!context.mounted) return;
        showSuccessMessage(context, "Parking Booked Successfully!");
        // fetchAllParkings();
        // Get.to(() => ParkingMain());
      } else if (result == "Parking name already exists.") {
        if (!context.mounted) return;
        showOverlayError(context, "Parking name already exists.");
      } else {
        if (!context.mounted) return;
        showOverlayError(context, "Can't create parking.");
      }
    } catch (e) {
      print('Unexpected error: $e');
    } finally {
      isLoading(false);
    }
  }
}
