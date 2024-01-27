import 'package:flutter/material.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/screens/Auth/login_screen.dart';
import 'package:vibeforge/screens/HomeScreen/home_screen.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (GlobalUtils.isloggedIn) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
