import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/customer_controller.dart';
import 'package:parknet_pro/custome_widget/logout_popup.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/user/single_card.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
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
                "welcome User",
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
            SizedBox(height: screenHeight * 0.025),

            Obx(() {
              if (controller.getParkingLoading.isTrue) {
                return const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (controller.parkingList.isEmpty) {
                  return Text(
                    "No Parkings Found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      // Set a bounded height to avoid unbounded error
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.separated(
                        itemBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: SingleCard(index: index),
                            ),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10),
                        itemCount: controller.parkingList.length,
                      ),
                    ),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
