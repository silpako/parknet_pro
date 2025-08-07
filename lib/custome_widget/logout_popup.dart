import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknet_pro/view/signin_screen.dart';

void showLogoutDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: AlertDialog(
            title: const Text(
              "Confirm Logout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
            content: const Text(
              "Are you sure you want to logout?",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final box = GetStorage();
                    await FirebaseAuth.instance.signOut();
                    box.remove("isAdminLoggedIn");
                    Get.offAll(() => const SignInScreen());
                  } catch (e) {
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logout failed: $e")),
                    );
                  }
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
