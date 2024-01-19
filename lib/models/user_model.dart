class UserModel {
  String email;
  String? userName;
  String? mobile;
  String? avatar;

  UserModel({
    required this.email,
    this.userName,
    this.mobile,
    this.avatar,
  });
}
