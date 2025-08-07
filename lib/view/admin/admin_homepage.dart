import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/homepage_controller.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/custome_widget/logout_popup.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/cancelled_parking/cancelled_parking_main.dart';
import 'package:parknet_pro/view/admin/currently_parked/currently_parked.dart';
import 'package:parknet_pro/view/admin/homepage_single_card.dart';
import 'package:parknet_pro/view/admin/parkings/parking_main.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  final bookingController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    bookingController.fetchAllCancelledBookingsForAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final HomepageController controller = Get.find<HomepageController>();
    controller.getAllCounts();
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
                "welcome Admin",
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
              child: const Icon(Icons.person_add_alt, color: AppColors.white),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SingleChildScrollView(
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
                SizedBox(height: screenHeight * 0.025),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomepageSingleCard(
                        cardIcon: Icons.local_parking_outlined,
                        cardText: "Total Parkings",
                        count: controller.countMap['totalParkings'] ?? 0,
                        classBuilder: () => ParkingMain(),
                      ),
                      HomepageSingleCard(
                        cardIcon: Icons.directions_car,
                        cardText: "Currently Parked",
                        count: controller.countMap['currentlyParked'] ?? 0,
                        classBuilder: () => CurrentlyParked(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomepageSingleCard(
                        cardIcon: Icons.account_balance_wallet,
                        cardText: "Total Revenue",
                        count:
                            (controller.countMap['totalRevenue'] ?? 0.0)
                                .toInt(),
                      ),
                      HomepageSingleCard(
                        cardIcon: Icons.cancel,
                        cardText: "Cancelled Bookings",
                        count: controller.countMap['cancelledBookings'] ?? 0,
                        classBuilder: () => CancelledParkingMain(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
