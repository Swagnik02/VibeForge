import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeforge/models/user_model.dart';

class AuthService {
  static const String userKey = 'user';

  List<User> _users = [];

  // Sign up
  Future<void> signUp(String userName, String email, String password) async {
    // Check if the email is already registered
    if (_users.any((user) => user.email == email)) {
      throw Exception('Email is already registered.');
    }

    // Create a new user and add to the list
    User newUser = User(userName: userName, email: email, password: password);
    _users.add(newUser);

    log('Signup successful for user: $userName');
  }

  // Sign in
  Future<void> signIn(String email, String password) async {
    // Check if the user with the given email and password exists
    User? user = _users
        .firstWhereOrNull((u) => u.email == email && u.password == password);

    if (user == null) {
      throw Exception('Invalid email or password.');
    }

    // Save user data to SharedPreferences after successful login
    await saveUser(user);

    log('Signin successful for user: ${user.userName}');
  }

  // Save user data to SharedPreferences
// Save user data to SharedPreferences
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    prefs.setString(userKey, userJson);
  }

  // Retrieve user data from SharedPreferences
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return User.fromJson(jsonMap);
    }

    return null;
  }

  // Sign out (not applicable in this basic example)
}

// void main() async {
//   AuthService authService = AuthService();

//   try {
//     // Example sign up
//     await authService.signUp('JohnDoe', 'john@example.com', 'password123');

//     // Example sign in
//     await authService.signIn('john@example.com', 'password123');

//     // Example retrieve user data after sign in
//     User? loggedInUser = await authService.getUser();
//     if (loggedInUser != null) {
//       log('User data after sign in: ${loggedInUser.toJson()}');
//     }
//   } catch (e) {
//     log('Error: $e');
//   }
// }
