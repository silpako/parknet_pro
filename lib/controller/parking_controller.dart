import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/error_response/error_message.dart';
import 'package:parknet_pro/error_response/success_message.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';
import 'package:parknet_pro/view/admin/parkings/parking_main.dart';

class ParkingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool getParkingLoading = false.obs;
  RxBool deleteParkingLoading = false.obs;
  RxList<Map<String, dynamic>> parkingList = <Map<String, dynamic>>[].obs;
  final firebaseFunctions = FirebaseFunctions();

  @override
  void onInit() {
    super.onInit();
    fetchAllParkings();
  }

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
        fetchAllParkings();
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

  void fetchAllParkings() async {
    try {
      getParkingLoading(true);

      List<Map<String, dynamic>> parkings =
          await firebaseFunctions.getParking();

      if (parkings.isNotEmpty) {
        parkingList.assignAll(parkings);
      }
    } catch (e) {
      print("error occured while getting: $e");
    } finally {
      getParkingLoading(false);
    }
  }

  void deleteParking(String id) async {
    try {
      deleteParkingLoading(true);

      final result = await firebaseFunctions.deleteParking(id);

      if (result == null) {
        fetchAllParkings();
        Get.snackbar(
          "Success",
          "Parking deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Handle error
        Get.snackbar(
          "Error",
          result,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error while deleting: $e");
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      deleteParkingLoading(false);
    }
  }
}
