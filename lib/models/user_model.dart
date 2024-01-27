import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String userName;
  final String email;
  final String password;

  User({required this.userName, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'email': email, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }
}
