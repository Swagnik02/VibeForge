import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/services/auth_service.dart';

class WelcomePageController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  AuthService authService = AuthService();
  void onSlideWelcome() async {
    await authService.welcome(userNameController.text).then((value) {
      UserDataService().fetchUserData('guestuser@user.com').then((_) async {
        // Store user data locally after successful login
        UserDataService().storeUserDataLocally();
        User? loggedInUser = await authService.getLoggedInUser();
        log('User data after sign in: ${loggedInUser?.toJson()}');
      });
      // Navigate to the welcome screen or perform any other desired actions
      Get.offAllNamed('/');
    });
  }

  Future<void> printAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> allData = prefs.getKeys().fold<Map<String, dynamic>>(
      {},
      (Map<String, dynamic> acc, String key) {
        acc[key] = prefs.get(key);
        return acc;
      },
    );

    print('All Data in Shared Preferences: $allData');
  }
}
