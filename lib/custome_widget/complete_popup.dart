import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/controller/booking_controller.dart';

Future<void> showCompleteConfirmationDialog(
  BuildContext context,
  String bookingId,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Complete Booking'),
        content: const Text('Are you sure you want to complete this booking?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              final controller = Get.find<BookingController>();
              controller.completeBooking(bookingId);
            },
          ),
        ],
      );
    },
  );
}
