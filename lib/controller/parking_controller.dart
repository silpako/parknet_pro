import 'package:get/state_manager.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';

class ParkingController extends GetxController {
  RxBool isLoading = false.obs;
  final firebaseFunctions = FirebaseFunctions(); // instance

  Future<void> addParking() async {
    try {
      isLoading(true);

      final result = await firebaseFunctions.postParking(
        parkingName: 'Green Parking Lot',
        description: 'Underground parking with 24/7 security',
        location: 'Palakkad',
        amount: 50.0,
        fineAmount: 60.0,
      );

      if (result == null) {
        print('Parking added successfully');
        // You can also show a success snackbar or dialog here
      } else {
        print('Error: $result');
        // Show error to user if needed
      }
    } catch (e) {
      print('Unexpected error: $e');
    } finally {
      isLoading(false);
    }
  }
}
