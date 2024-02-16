import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLearn extends StatefulWidget {
  const LottieLearn({Key? key}) : super(key: key);

  @override
  State<LottieLearn> createState() => _LottieLearnState();
}

class _LottieLearnState extends State<LottieLearn>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final AnimationController darkmodeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    final AnimationController favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    bool isLight = false;
    bool isFavorite = false;
    const String favoriteButton =
        "https://assets10.lottiefiles.com/packages/lf20_slDcnv.json";
    const String darkMode =
        "https://assets10.lottiefiles.com/packages/lf20_tbyegho2.json";

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () async {
                await darkmodeController.animateTo(isLight ? 0.5 : 1);
                // controller.animateTo(0.5);
                isLight = !isLight;
              },
              child: Lottie.network(darkMode,
                  repeat: false, controller: darkmodeController)),
        ],
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () async {
            await favoriteController.animateTo(isFavorite ? 1 : 0);
            isFavorite = !isFavorite;
          },
          child: Lottie.asset('assets/images/fav_btn.json',
              repeat: false, controller: favoriteController),
        ),
      ]),
    );
  }
}
