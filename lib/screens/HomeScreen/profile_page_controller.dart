import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/models/user_model.dart';

class ProfilePageController extends GetxController {
  var index = 0;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(
        text: UserDataService().user?.userName ?? 'UserName');
    emailController =
        TextEditingController(text: UserDataService().user?.email ?? 'e-mail');
    mobileController =
        TextEditingController(text: UserDataService().user?.mobile ?? '');
  }

  void saveProfile() {}
  void editWindow() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(16),
      title: 'Edit Profile',
      titleStyle: Get.textTheme.headlineSmall!.copyWith(
          color: Colors.deepPurple.shade900, fontWeight: FontWeight.bold),
      content: Column(
        children: [
          Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                controller: userNameController,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  label: Text('Mobile'),
                  prefixIcon: Icon(Icons.call),
                ),
                controller: mobileController,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => onTapUpdateProfile(),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onTapUpdateProfile() async {
    try {
      User updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
    } catch (error) {
      log('Error updating profile: $error');
    }
  }

  User getUserDataFromEditedValues() {
    String updatedUserName = userNameController.text;
    String updatedMobile = mobileController.text;

    return User(
      userName: updatedUserName,
      mobile: updatedMobile,
      email: UserDataService().user!.email,
      password: UserDataService().user!.password,
    );
  }
}
