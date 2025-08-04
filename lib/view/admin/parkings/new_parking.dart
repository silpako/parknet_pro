import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/parking_controller.dart';
import 'package:parknet_pro/utils/app_colors.dart';

class NewParking extends StatefulWidget {
  final Map<String, dynamic>? parking;

  const NewParking({super.key, this.parking});

  @override
  State<NewParking> createState() => _NewParkingState();
}

class _NewParkingState extends State<NewParking> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;
  late TextEditingController fineController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.parking?['parkingName'] ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.parking?['description'] ?? '',
    );
    locationController = TextEditingController(
      text: widget.parking?['location'] ?? '',
    );
    priceController = TextEditingController(
      text: widget.parking?['amount']?.toString() ?? '',
    );
    fineController = TextEditingController(
      text: widget.parking?['fineAmount']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    fineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ParkingController controller = Get.put(ParkingController());

    return Scaffold(
      backgroundColor: AppColors.white,
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
        title: Text(
          widget.parking != null ? "Edit Parking" : "Add New Parking",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(
                label: 'Parking Name',
                icon: Icons.local_parking,
                controller: nameController,
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Description',
                icon: Icons.description,
                controller: descriptionController,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Location',
                icon: Icons.location_on,
                controller: locationController,
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Price per Day (₹)',
                icon: Icons.currency_rupee,
                controller: priceController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),
              buildTextField(
                label: 'Fine Amount (₹)',
                icon: Icons.currency_rupee,
                controller: fineController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  final isLoading =
                      widget.parking != null
                          ? controller.isEditingLoading.value
                          : controller.isLoading.value;

                  return isLoading
                      ? const Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                      )
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.parking != null) {
                              controller.updateParking(
                                widget.parking!['id'],
                                nameController.text,
                                descriptionController.text,
                                locationController.text,
                                priceController.text,
                                fineController.text,
                              );
                            } else {
                              controller.addParking(
                                context,
                                nameController.text,
                                descriptionController.text,
                                locationController.text,
                                priceController.text,
                                fineController.text,
                              );
                            }
                          }
                        },
                        child: Text(
                          widget.parking != null
                              ? "Edit Parking"
                              : "Save Parking",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Please enter $label' : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppColors.lightPurple.withOpacity(0.05),
      ),
    );
  }
}
