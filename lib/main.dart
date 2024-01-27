import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/app_pages.dart';
import 'package:vibeforge/screens/HomeScreen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VibeForge',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: '/splash',
      home: HomeScreen(),
      getPages: AppPages.appPages,
    );
  }
}
