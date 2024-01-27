import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    animationInitialization();
    super.onInit();
  }

  animationInitialization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    // Listen for animation completion
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next screen (e.g., HomeScreen)
        Get.offNamed('/auth');
      }
    });

    animationController.forward();
  }
}
