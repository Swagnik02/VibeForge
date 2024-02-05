import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/services/auth_service.dart';

class SignUpScreenController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  AuthService authService = AuthService(); // Instantiate the AuthService

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController(text: TestProfile.userName);
    emailController = TextEditingController(text: TestProfile.email);
    passwordController = TextEditingController(text: TestProfile.password);
  }

  void goToLogin() async {
    Get.back();
  }

  void signup() async {
    try {
      await authService.signUp(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
      Get.offAllNamed('/auth');
    } catch (e) {
      log('Error: $e');
    }
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
