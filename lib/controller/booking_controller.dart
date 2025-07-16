import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BookingController extends GetxController {
  RxInt days = 1.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final int pricePerDay = 50;
  RxInt totalPrice = 50.obs;

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
}
