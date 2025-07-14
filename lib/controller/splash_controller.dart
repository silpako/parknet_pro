import 'package:get/get.dart';
import 'package:parknet_pro/view/signin_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(() => SignInScreen());
  }
}
