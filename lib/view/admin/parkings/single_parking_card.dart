import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/parking_controller.dart';
import 'package:parknet_pro/error_response/delete_popup.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/view/admin/parkings/new_parking.dart';

class SingleParkingCard extends StatelessWidget {
  final int index;
  const SingleParkingCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final ParkingController controller = Get.find<ParkingController>();
    final parking = controller.parkingList[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD6D9DD),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Parking Name
            Text(
              parking['parkingName'] ?? '',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 4),

            /// Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    parking['location'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            /// Description
            Text(
              parking['description'] ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),

            /// Chips
            Row(
              children: [
                _InfoChip(
                  icon: Icons.currency_rupee,
                  label: '${parking['amount']} / day',
                  color: Colors.green.shade700,
                  bgColor: Colors.green.shade100,
                ),
                const SizedBox(width: 6),
                _InfoChip(
                  icon: Icons.warning_amber_rounded,
                  label: '${parking['fineAmount']} fine',
                  color: Colors.red.shade700,
                  bgColor: Colors.red.shade100,
                ),
              ],
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.local_parking, size: 16, color: Colors.black),
                const SizedBox(width: 4),
                Text(
                  "Total: ${parking['noOfSlot']} | "
                  "Booked: ${parking['bookedSlots']} | "
                  "Available: ${parking['availableSlots']}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            /// Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ActionButton(
                  icon: Icons.edit,
                  label: "Edit",
                  onTap: () {
                    Get.to(() => NewParking(parking: parking));
                  },
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.delete,
                  label: "Delete",
                  onTap: () {
                    showDeleteDialog(context, "Parking", () async {
                      controller.deleteParking(parking['id']);
                    });
                  },
                  color: AppColors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: color),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
