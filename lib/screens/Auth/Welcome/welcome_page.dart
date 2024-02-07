import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:action_slider/action_slider.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/screens/Auth/Welcome/welcome_page_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final WelcomePageController controller = Get.put(WelcomePageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomePageController>(
      builder: (_) => Container(
        decoration: boxDecor(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: _mainBody(),
        ),
      ),
    );
  }

  // Background Gradient Colour

  BoxDecoration boxDecor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorConstants.themeColourShade1,
          ColorConstants.themeColourShade2,
          ColorConstants.themeColourShade3,
        ],
      ),
    );
  }

  _mainBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextButton(
          //     onPressed: () => controller.printAllData(), child: Text('check')),
          SizedBox(
            height: 100,
          ),
          _logo(),
          _welcomeText(),
          const SizedBox(height: 16.0),
          _inputUserName(),
          const SizedBox(height: 16.0),
          // action slider 1
          _actionSlider(() => controller.onSlideWelcome()),
          Lottie.asset('assets/images/wave_horizontal.json'),
        ],
      ),
    );
  }

  _logo() {
    return Image.asset(
      LocalAssets.appLogo,
      width: 160,
      // color: Colors.deepPurple.shade100,
    );
  }

  _welcomeText() {
    return Text(
      'Welcome to Vibe Forge',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.deepPurple.shade400,
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      ),
    );
  }

  _inputUserName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          style: TextStyle(color: Colors.deepPurple.shade900, fontSize: 30),
          controller: controller.userNameController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.center,
            hintText: 'Enter your name',
            hintStyle: TextStyle(fontSize: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
        ),
      ),
    );
  }

  _actionSlider(
    VoidCallback onSlide,
  ) {
    return ActionSlider.standard(
      rolling: true,
      width: 300.0,
      backgroundColor: const Color.fromARGB(149, 66, 31, 126),
      reverseSlideAnimationCurve: Curves.easeInOut,
      reverseSlideAnimationDuration: const Duration(milliseconds: 500),
      toggleColor: Colors.purpleAccent,
      icon: const Icon(Icons.headphones),
      successIcon: Image.asset(
        LocalAssets.appLogo,
        color: Colors.deepPurple.shade900,
      ),
      action: (controller) async {
        controller.loading(); //starts loading animation
        await Future.delayed(const Duration(seconds: 1));
        controller.success(); //starts success animation
        await Future.delayed(const Duration(seconds: 1));
        controller.reset(); //resets the slider
        onSlide();
      },
      child: const Text('DIVE INTO MUSIC',
          style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}
