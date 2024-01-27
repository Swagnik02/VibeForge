import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/services/auth_service.dart';

class LoginScreenController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  AuthService authService = AuthService(); // Instantiate the AuthService

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController(text: TestProfile.userName);
    emailController = TextEditingController(text: TestProfile.email);
    passwordController = TextEditingController(text: 'password02');
  }

  void login() async {
    try {
      // Call the sign-in method from AuthService
      await authService.signIn(emailController.text, passwordController.text);

      // Get the user data after sign in
      User? loggedInUser = await authService.getUser();

      if (loggedInUser != null) {
        log('User data after sign in: ${loggedInUser.toJson()}');
        GlobalUtils.isloggedIn = true;
        Get.offAllNamed('/');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void signup() async {
    try {
      // Call the sign-in method from AuthService
      await authService.signUp(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      // // Get the user data after sign in
      // User? loggedInUser = await authService.getUser();

      // if (loggedInUser != null) {
      //   log('User data after sign in: ${loggedInUser.toJson()}');
      //   GlobalUtils.isloggedIn = true;
      //   Get.offAllNamed('/');
      // }
    } catch (e) {
      log('Error: $e');
    }
  }
}
