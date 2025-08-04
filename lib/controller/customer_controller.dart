import 'package:get/state_manager.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';

class CustomerController extends GetxController {
  RxBool getParkingLoading = false.obs;
  RxList<Map<String, dynamic>> parkingList = <Map<String, dynamic>>[].obs;
  final firebaseFunctions = FirebaseFunctions();

  @override
  void onInit() {
    print("------------- customer controller iit");
    super.onInit();
    fetchAllParkings();
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
}
