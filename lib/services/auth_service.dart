import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeforge/models/user_model.dart';

class AuthService {
  static const String userKey = 'user';
  static const String loggedInUserKey = 'loggedinUserdata';

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

  Future<void> welcome(String userName) async {
    // Check if the username is already taken
    if (_users.any((user) => user.userName == userName)) {
      throw Exception('Username is already taken.');
    }

    // Create a new user with only the provided username
    User newUser = User(
      userName: userName,
      email: 'guestuser@user.com',
      password: '',
    );

    // Add the new user to the list
    _users.add(newUser);

    // Save the updated user list to SharedPreferences
    await saveUsers();

    log('Welcome process successful for user: $userName');

    await saveLoggedInUser(newUser);
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
    prefs.setString(loggedInUserKey, userJson);
  }

  // Retrieve logged-in user data from SharedPreferences
  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(loggedInUserKey);

    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return User.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(loggedInUserKey);
    Get.offAllNamed('/auth');
    log('Logout successful');
  }
}
