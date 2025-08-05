import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/error_response/error_message.dart';
import 'package:parknet_pro/error_response/success_message.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';
import 'package:parknet_pro/view/user/my_bookings/my_bookings.dart';

class BookingController extends GetxController {
  RxInt days = 1.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final int pricePerDay = 50;
  RxInt totalPrice = 50.obs;
  RxBool isLoading = false.obs;
  RxBool getBookingForAdminLoading = false.obs;
  RxBool getBookingLoading = false.obs;
  final firebaseFunctions = FirebaseFunctions();
  RxList<Map<String, dynamic>> bookingList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> bookingListForAdmin =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllBookings();
  }

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
        fetchAllBookings();
        Get.to(() => MyBookings());
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

  void fetchAllBookings() async {
    try {
      getBookingLoading(true);

      List<Map<String, dynamic>> bookings =
          await firebaseFunctions.getMyBookings();

      if (bookings.isNotEmpty) {
        bookingList.assignAll(bookings);
      }
    } catch (e) {
      print("error occured while getting: $e");
    } finally {
      getBookingLoading(false);
    }
  }

  void fetchAllBookingsForAdmin() async {
    try {
      getBookingForAdminLoading(true);

      List<Map<String, dynamic>> bookings =
          await firebaseFunctions.getAllBookingsForAdmin();

      if (bookings.isNotEmpty) {
        bookingListForAdmin.assignAll(bookings);
      }
    } catch (e) {
      print("error occured while getting: $e");
    } finally {
      getBookingForAdminLoading(false);
    }
  }
}
