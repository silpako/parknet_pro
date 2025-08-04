import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/customer_controller.dart';
import 'package:parknet_pro/utils/app_assets.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/user/book_now_page.dart';

class SingleCard extends StatelessWidget {
  final int index;
  const SingleCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final CustomerController controller = Get.find<CustomerController>();
    final parking = controller.parkingList[index];
    return Container(
      width: double.infinity,
      color: AppColors.lightPurple, // background of the whole screen
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              parking['parkingName'] ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 140,
                    width: 140,
                    child: Image.asset(
                      AppAssets.splashScreenImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        parking['description'] ?? '',
                        style: TextStyle(fontSize: 14, height: 1.4),
                        softWrap: true,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              parking['location'] ?? '',
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Charge/day",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rs. ${parking['amount'] ?? ''}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => BookNowPage());
                  },
                  child: Container(
                    height: 44,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
