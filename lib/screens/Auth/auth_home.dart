import 'package:flutter/material.dart';
import 'package:vibeforge/models/user_model.dart';
import 'package:vibeforge/screens/Auth/login_screen.dart';
import 'package:vibeforge/screens/HomeScreen/home_screen.dart';
import 'package:vibeforge/services/auth_service.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  _AuthHomeState createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  late AuthService authService;
  late Future<User?> loggedInUser;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    loggedInUser = authService.getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: loggedInUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator if the future is still in progress
          return CircularProgressIndicator();
        } else {
          return snapshot.hasData ? HomeScreen() : LoginScreen();
        }
      },
    );
  }
}
