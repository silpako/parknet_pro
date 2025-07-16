import 'package:flutter/material.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class SingleParkingCard extends StatelessWidget {
  const SingleParkingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: AppColors.primaryColor.withOpacity(0.7),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Lulu Mall Parking",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              "Kochi's leading supermarket and departmental store offering everything from groceries to electronics and much more.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 5),

            // Location & Amount Row
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text("Kochi, Kerala", style: TextStyle(fontSize: 14)),
                Spacer(),
                Icon(Icons.currency_rupee, size: 20, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  "50 / day",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // Edit & Delete Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Handle Edit
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                  label: const Text(
                    "Edit",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    // Handle Delete
                  },
                  icon: const Icon(Icons.delete, size: 18, color: AppColors.red),
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: AppColors.red),
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
