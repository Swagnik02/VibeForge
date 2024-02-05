import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeforge/services/auth_service.dart';

class User {
  String? userName;
  String email;
  String? mobile;
  String password;

  User({
    this.userName,
    required this.email,
    this.mobile,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'email': email, 'password': password};
  }

  @override
  String toString() {
    return 'User(userName: $userName, email: $email, mobile: $mobile, password: $password)';
  }
}

class UserDataService {
  static final UserDataService _instance = UserDataService._internal();

  factory UserDataService() => _instance;

  UserDataService._internal();

  User? _user;

  User? get user => _user;

  Future<void> fetchUserData(String userEmail) async {
    try {
      final authService = AuthService();
      final loggedInUser = await authService.getLoggedInUser();

      // if (loggedInUser == null || loggedInUser.email != userEmail) {
      // return;
      //     }

      // the Welcome Page case
      if (loggedInUser == null) {
        return;
      }

      _user = User(
        mobile: loggedInUser.mobile,
        userName: loggedInUser.userName,
        email: loggedInUser.email,
        password: loggedInUser.password,
      );

      log('User Data for $userEmail: $_user');
    } catch (e) {
      log('Error collecting user data: $e');
    }
  }

  void storeUserDataLocally() {
    if (_user != null) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('user_email', _user!.email);
        prefs.setString('user_name', _user?.userName ?? '');
        prefs.setString('mobile', _user?.mobile ?? '');
      });
    }
  }

  Future<void> retrieveUserDataLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('user_email') ?? "";
    if (userEmail.isNotEmpty) {
      await fetchUserData(userEmail);
    }
  }

  Future<void> updateUserData(User updatedUserData) async {
    try {
      final authService = AuthService();
      final loggedInUser = await authService.getLoggedInUser();

      if (loggedInUser == null) {
        return;
      }

      loggedInUser.mobile = updatedUserData.mobile;
      loggedInUser.userName = updatedUserData.userName;

      await authService.saveLoggedInUser(loggedInUser);

      _user = updatedUserData;
      storeUserDataLocally();
    } catch (e) {
      log('Error updating user data: $e');
    }
  }

  Future<void> clearUserDataLocally() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
  }
}
