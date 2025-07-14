import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/splash_controller.dart';
import 'package:parknet_pro/view/splash.dart';

void main() {
  Get.lazyPut(() => SplashController());
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
      home: const SplashScreen(),
    );
  }
}
