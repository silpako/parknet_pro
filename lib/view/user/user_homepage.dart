import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/customer_controller.dart';
import 'package:parknet_pro/custome_widget/logout_popup.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/user/cancelled/cancelled.dart';
import 'package:parknet_pro/view/user/completed/completed.dart';
import 'package:parknet_pro/view/user/my_bookings/my_bookings.dart';
import 'package:parknet_pro/view/user/single_card.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  String userName = "User";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? user.email?.split('@').first ?? "User";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final CustomerController controller = Get.put(CustomerController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: screenHeight * 0.10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.07,
              child: const Icon(Icons.person),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                "Welcome $userName",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                showLogoutDialog(context);
              },
              child: const Icon(Icons.logout, color: AppColors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.03,
              width: screenWidth * screenWidth,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(40),
                  bottomEnd: Radius.circular(40),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // 🚗 Booking Buttons Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.receipt_long, color: Colors.white),
                      label: const Text(
                        "My Booking",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => MyBookings());
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Cancelled",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => Cancelled());
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => Completed());
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            // 🅿️ Parking List
            Obx(() {
              if (controller.getParkingLoading.isTrue) {
                return const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (controller.parkingList.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "No Parkings Found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 25),
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleCard(index: index),
                          ),
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemCount: controller.parkingList.length,
                    ),
                  ),
                );
              }
            }),

            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}
