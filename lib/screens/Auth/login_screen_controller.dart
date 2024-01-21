import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';

class LoginScreenController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController(text: TestProfile.userName);
    emailController = TextEditingController(text: TestProfile.email);
    mobileController = TextEditingController(text: TestProfile.mobile);
  }

  void login() {
    log('Login');
    log('Username: ${usernameController.text}');
    log('Email: ${emailController.text}');
    log('Mobile: ${mobileController.text}');
  }
}
