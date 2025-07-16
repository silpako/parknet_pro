import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BookingController extends GetxController {
  RxInt days = 1.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void increaseDays() {
    days.value++;
  }

  void decreaseDays() {
    if (days.value > 1) {
      days.value--;
    }
  }

  void resetDays() {
    days.value = 1;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
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
