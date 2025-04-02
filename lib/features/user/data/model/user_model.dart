class UserModel {
  String email;
  UserRole role;

  UserModel({
    required this.email,
    required this.role,
  });
}

enum UserRole {
  reader,
  keeper,
}
