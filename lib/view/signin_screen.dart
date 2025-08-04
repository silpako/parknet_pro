import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknet_pro/custome_widget/custome_textformfiled.dart';
import 'package:parknet_pro/custome_widget/ouline_and_greenbutton.dart';
import 'package:parknet_pro/firebase/firebase_function.dart';
import 'package:parknet_pro/utils/app_assets.dart';
import 'package:parknet_pro/utils/app_colors.dart';
import 'package:parknet_pro/utils/app_textstyle.dart';
import 'package:parknet_pro/view/admin/admin_homepage.dart';
import 'package:parknet_pro/view/signup_screen.dart';
import 'package:parknet_pro/view/user/user_homepage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isRememberMe = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Sign In", style: AppTextStyles.appBarTitle),
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
                  const Text("Email Address", style: AppTextStyles.boldText),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    hintText: "Enter your email address",
                    controller: emailcontroller,
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
                    controller: passwordcontroller,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                isRememberMe = value!;
                              });
                            },
                            activeColor: AppColors.primaryColor,
                          ),
                          Text("Remember Me", style: AppTextStyles.normalText),
                        ],
                      ),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GreenButton(
                    text: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (emailcontroller.text == "admin@gmail.com" &&
                            passwordcontroller.text == "12345") {
                          Get.offAll(() => AdminHomepage());
                        } else {
                          FirebaseFunctions()
                              .loginUser(
                                emaill: emailcontroller.text.trim(),
                                password: passwordcontroller.text.trim(),
                              )
                              .then((response) {
                                if (response == null) {
                                  Get.offAll(() => UserHomepage());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(response)),
                                  );
                                }
                              });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(color: AppColors.grey, thickness: 1),
                      ),
                      SizedBox(width: 10),
                      Text("Or continue with", style: AppTextStyles.normalText),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(color: AppColors.grey, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BorderButton(
                    text: "Continue with Google",
                    image: Image.asset(
                      AppAssets.googleIcon,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      // Add Google Sign-In logic here
                    },
                  ),
                  const SizedBox(height: 16),
                  BorderButton(
                    text: "Continue with Facebook",
                    image: Image.asset(
                      AppAssets.facebookIcon,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.normalText,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const SignUpScreen());
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
