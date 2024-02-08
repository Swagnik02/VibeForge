import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/splashScreen/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: GetBuilder<SplashScreenViewModel>(
        init: SplashScreenViewModel(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(LocalAssets.loadingAnim),
                  Text(
                    UsedStrings.appName,
                    style: TextStyle(
                        fontFamily: "ProtestRiot-Regular",
                        fontSize: 50,
                        color: ColorConstants.themeColour),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
