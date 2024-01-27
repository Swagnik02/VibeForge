import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeforge/models/user_model.dart';

class AuthService {
  static const String userKey = 'user';
  static const String loggedInUserKey =
      'loggedinUserdata'; // New key for logged-in user data

  List<User> _users = [];

  // Initialize AuthService and load users from SharedPreferences
  AuthService() {
    loadUsers();
  }

  // Load users from SharedPreferences
  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getStringList(userKey);

    if (jsonString != null) {
      _users = jsonString
          .map(
            (json) => User.fromJson(jsonDecode(json)),
          )
          .toList();
    }
  }

  // Sign up
  Future<void> signUp(String userName, String email, String password) async {
    // Check if the email is already registered
    if (_users.any((user) => user.email == email)) {
      throw Exception('Email is already registered.');
    }

    // Create a new user and add to the list
    User newUser = User(userName: userName, email: email, password: password);
    _users.add(newUser);

    // Save updated user list to SharedPreferences
    await saveUsers();

    log('Signup successful for user: $userName');
  }

  // Save users list to SharedPreferences
  Future<void> saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final userListJson =
        _users.map((user) => json.encode(user.toJson())).toList();
    prefs.setStringList(userKey, userListJson);
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
    await saveLoggedInUser(user);

    log('Signin successful for user: ${user.userName}');
  }

  // Save logged-in user data to SharedPreferences
  Future<void> saveLoggedInUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    prefs.setString(
        loggedInUserKey, userJson); // Use the new key for logged-in user data
  }

  // Retrieve logged-in user data from SharedPreferences
  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs
        .getString(loggedInUserKey); // Use the new key for logged-in user data

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return User.fromJson(jsonMap);
    }
    return null;
  }
}
