import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/screens/Auth/Login/login_screen.dart';
import 'package:vibeforge/screens/Auth/Welcome/welcome_page.dart';
import 'package:vibeforge/screens/HomeScreen/home_screen.dart';
import 'package:vibeforge/screens/playlist_screen.dart';
import 'package:vibeforge/splashScreen/splash_screen.dart';
import 'package:vibeforge/screens/Auth/auth_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Retrieve user data from local storage
  MetadataGod.initialize();
  await UserDataService().retrieveUserDataLocally();
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
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      initialRoute: '/splash',
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/auth', page: () => const AuthHome()),
        GetPage(name: '/welcome', page: () => WelcomePage()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
      ],
    );
  }
}
