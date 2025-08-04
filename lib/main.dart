import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/controller/customer_controller.dart';
import 'package:parknet_pro/controller/parking_controller.dart';
import 'package:parknet_pro/controller/splash_controller.dart';
import 'package:parknet_pro/view/admin/admin_homepage.dart';
import 'package:parknet_pro/view/admin/parkings/new_parking.dart';
import 'package:parknet_pro/view/admin/parkings/parking_main.dart';
import 'package:parknet_pro/view/signin_screen.dart';
import 'package:parknet_pro/view/splash.dart';
import 'package:parknet_pro/view/user/user_homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBuVo_VviNdd9l07vV8Hm5TgTvshlz-C-M",
      appId: "1:222670100529:android:d115f8a8c15de74baddd10",
      messagingSenderId: "222670100529",
      projectId: "parkingsystem-c415d",
    ),
  );
  User? user = FirebaseAuth.instance.currentUser;
  Get.lazyPut(() => SplashController());
  Get.put(BookingController());
  Get.put(ParkingController());
  Get.put(CustomerController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ParkNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
