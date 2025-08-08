import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/custome_widget/custome_textformfiled.dart';
import 'package:parknet_pro/custome_widget/ouline_and_greenbutton.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/utils/app_textstyle.dart';
import 'package:parknet_pro/view/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isTermsAccepted = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Sign Up", style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top,
          ),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text("Name", style: AppTextStyles.boldText),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    hintText: "Enter your full name",
                    controller: nameController,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text("Email Address", style: AppTextStyles.boldText),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    hintText: "Enter your email address",
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text("Password", style: AppTextStyles.boldText),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    hintText: "Enter your password",
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text("Confirm Password", style: AppTextStyles.boldText),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    hintText: "Re-enter your password",
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isTermsAccepted,
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            isTermsAccepted = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "I accept the Terms & Conditions",
                          style: AppTextStyles.normalText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GreenButton(
                        text: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (!isTermsAccepted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please accept the Terms & Conditions',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            setState(() => isLoading = true);

                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String pass = passwordController.text.trim();

                            FirebaseFunctions()
                                .registerUser(
                                  name: name,
                                  email: email,
                                  password: pass,
                                )
                                .then((response) {
                                  setState(
                                    () => isLoading = false,
                                  ); // Stop loader

                                  if (response == null) {
                                    Get.to(() => const SignInScreen());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(response)),
                                    );
                                  }
                                });
                          }
                        },
                      ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: AppTextStyles.normalText,
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
