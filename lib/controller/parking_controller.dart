import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/error_response/error_message.dart';
import 'package:parknet_pro/error_response/success_message.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';
import 'package:parknet_pro/view/admin/parkings/parking_main.dart';

class ParkingController extends GetxController {
  RxBool isLoading = false.obs;
  final firebaseFunctions = FirebaseFunctions(); // instance

  Future<void> addParking(
    BuildContext context,
    parkingName,
    description,
    location,
    amountString,
    fineAmountString,
  ) async {
    try {
      isLoading(true);
      double amount = double.parse(amountString);
      double fineAmount = double.parse(fineAmountString);

      final result = await firebaseFunctions.postParking(
        parkingName: parkingName,
        description: description,
        location: location,
        amount: amount,
        fineAmount: fineAmount,
      );

      if (result == null) {
        if (!context.mounted) return;
        showSuccessMessage(context, "Parking Created Successfully!");
        Get.to(() => ParkingMain());
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
