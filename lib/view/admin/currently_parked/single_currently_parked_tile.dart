import 'package:flutter/material.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class SingleCurrentlyParkedTile extends StatelessWidget {
  const SingleCurrentlyParkedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black12,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.lightPurple.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // 🚗 Vehicle Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.directions_car_filled_rounded,
                color: AppColors.primaryColor,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "KL-07-AB-1234",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Lulu Mall Parking - Kochi",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Started at: 16 July 2025, 10:30 AM",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Status Icon
            Column(
              children: const [
                Icon(Icons.timelapse, color: Colors.orange, size: 22),
                SizedBox(height: 4),
                Text(
                  "Ongoing",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
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
