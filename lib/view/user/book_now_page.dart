import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknet_pro/controller/booking_controller.dart';
import 'package:parknet_pro/utils/app_assets.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class BookNowPage extends StatefulWidget {
  final String parkingId;
  final String parkingName;
  final double amount;
  final String location;
  const BookNowPage({
    super.key,
    required this.parkingId,
    required this.parkingName,
    required this.amount,
    required this.location,
  });

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  final BookingController bookingController = Get.find<BookingController>();
  
  late TextEditingController vehicleController;

  @override
  void initState() {
    super.initState();
    bookingController.assignValues(widget.amount);
    vehicleController = TextEditingController();
  }

  @override
  void dispose() {
    vehicleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        title: const Text(
          "Book Now",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🖼️ Parking Image
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppAssets.splashScreenImg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 📍 Parking Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.parkingName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Charge per day: Rs. ${widget.amount.toString()}",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(widget.location, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 📅 Booking Form
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please select date and number of days",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 📆 Date Picker
                    Obx(() {
                      return GestureDetector(
                        onTap: () => bookingController.pickDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                bookingController.selectedDate.value != null
                                    ? DateFormat('dd MMM yyyy').format(
                                      bookingController.selectedDate.value!,
                                    )
                                    : 'Select Date',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // 🔢 Days Counter
                    Obx(() {
                      return Row(
                        children: [
                          const Text(
                            "Days:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          buildCounterButton(
                            Icons.remove,
                            bookingController.decreaseDays,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${bookingController.days}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          buildCounterButton(
                            Icons.add,
                            bookingController.increaseDays,
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 20),

                    // 🚘 Vehicle Number Input
                    TextField(
                      controller: vehicleController,
                      decoration: InputDecoration(
                        labelText: 'Vehicle Number (e.g., KL-07-AB-1234)',
                        prefixIcon: const Icon(Icons.directions_car),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 💰 Price Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "Total Payable: ₹${bookingController.totalPrice.value}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "⚠️ A penalty will apply if the vehicle is not returned on time.",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Confirm Booking
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        bookingController.isLoading.value
                            ? null // Disable button while loading
                            : () {
                              final vehicleNumber =
                                  vehicleController.text.trim();
                              if (vehicleNumber.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please enter vehicle number",
                                  backgroundColor: Colors.red.shade100,
                                );
                                return;
                              }

                              bookingController.bookParking(
                                context,
                                widget.parkingId,
                                widget.parkingName,
                                DateFormat(
                                  'yyyy-MM-dd',
                                ).format(bookingController.selectedDate.value!),
                                bookingController.days.value,
                                vehicleNumber,
                                bookingController.totalPrice.value,
                              );
                            },
                    child:
                        bookingController.isLoading.value
                            ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                            : const Text(
                              "Confirm Booking",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCounterButton(IconData icon, VoidCallback onPressed) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }
}
