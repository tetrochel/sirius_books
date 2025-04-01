import 'package:sirius_books/features/user/data/model/user.dart';

abstract interface class UserRepository {
  Future<UserModel?> login(String email, String password);

  Future<void> logout();

  Future<void> resetPassword(String email);
}