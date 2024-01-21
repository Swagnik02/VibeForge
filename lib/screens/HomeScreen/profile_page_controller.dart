import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';

class ProfilePageController extends GetxController {
  var index = 0;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController(text: TestProfile.userName);
    emailController = TextEditingController(text: TestProfile.email);
    mobileController = TextEditingController(text: TestProfile.mobile);
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
                decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                controller: userNameController,
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
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
                onPressed: () {},
                child: const Text('Start'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
