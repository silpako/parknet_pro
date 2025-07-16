import 'package:flutter/material.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class SingleCancelledParkingTile extends StatelessWidget {
  const SingleCancelledParkingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black12,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // ❌ Cancelled Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cancel, color: AppColors.red, size: 26),
            ),

            const SizedBox(width: 16),

            // Vehicle and location details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "KL-11-CD-5678",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Infopark Parking - Kakkanad",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Cancelled on: 15 July 2025, 04:45 PM",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // ❗ Cancelled label
            Column(
              children: const [
                Icon(Icons.error_outline, color: Colors.red, size: 22),
                SizedBox(height: 4),
                Text(
                  "Cancelled",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
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
