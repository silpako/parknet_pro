import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class HomepageSingleCard extends StatelessWidget {
  final IconData cardIcon;
  final String cardText;
  final int count;
  final bool isLoading;
  final Widget Function()? classBuilder;

  const HomepageSingleCard({
    super.key,
    required this.cardIcon,
    required this.cardText,
    required this.count,
    this.isLoading = false,
    this.classBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (classBuilder != null) {
          Get.to(classBuilder!);
        }
      },
      child: Card(
        color: AppColors.white,
        elevation: 8,
        shadowColor: AppColors.primaryColor.withOpacity(0.5),
        child: SizedBox(
          width: 170,
          height: 175,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cardIcon, size: 40, color: AppColors.primaryColor),
                const SizedBox(height: 10),
                Text(
                  cardText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    )
                    : Text(
                      count.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
