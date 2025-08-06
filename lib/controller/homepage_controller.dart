import 'package:get/get.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';

class HomepageController extends GetxController {
  RxMap<String, dynamic> countMap = <String, dynamic>{}.obs;
  RxBool isLoading = false.obs;
  final firebaseFunctions = FirebaseFunctions();

  void getAllCounts() async {
    try {
      isLoading(true);
      Map<String, dynamic> counts =
          await firebaseFunctions.fetchDashboardCounts();
      countMap.assignAll(counts);
    } catch (e) {
      print("error occurred while getting: $e");
    } finally {
      isLoading(false);
    }
  }
}
