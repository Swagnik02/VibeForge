import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/screens/Auth/signup_screen.dart';
import 'package:vibeforge/services/auth_service.dart';

class LoginScreenController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  AuthService authService = AuthService(); // Instantiate the AuthService

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController(text: TestProfile.email);
    passwordController = TextEditingController(text: TestProfile.password);
  }

  void login() async {
    try {
      // Call the sign-in method from AuthService
      await authService.signIn(emailController.text, passwordController.text);

      // Get the user data after sign in
      User? loggedInUser = await authService.getLoggedInUser();

      if (loggedInUser != null) {
        log('User data after sign in: ${loggedInUser.toJson()}');
        GlobalUtils.isloggedIn = true;
        Get.offAllNamed('/');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void goToSignUp() {
    Get.to(
      SignUpScreen(),
      transition: Transition.rightToLeft,
    );
  }

  // Future<void> printAllData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String, dynamic> allData = prefs.getKeys().fold<Map<String, dynamic>>(
  //     {},
  //     (Map<String, dynamic> acc, String key) {
  //       acc[key] = prefs.get(key);
  //       return acc;
  //     },
  //   );

  //   print('All Data in Shared Preferences: $allData');
  // }
}
