import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknet_pro/view/admin/admin_homepage.dart';
import 'package:parknet_pro/view/signin_screen.dart';
import 'package:parknet_pro/view/user/user_homepage.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;
    final isAdminLoggedIn = box.read("isAdminLoggedIn") ?? false;

    if (user != null) {
      Get.offAll(() => const UserHomepage());
    } else if (isAdminLoggedIn) {
      Get.offAll(() => const AdminHomepage());
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }
}



// void _initSplash() async {
//     await Future.delayed(const Duration(seconds: 3));

//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       Get.offAll(() => const UserHomepage());
//     } else {
//       Get.offAll(() => const SignInScreen());
//     }
//   }