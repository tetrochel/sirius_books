import 'package:sirius_books/features/user/data/model/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel?> login(String email, String password);

  Future<void> logout();

  Future<void> resetPassword(String email);

  Future<void> signUp(String email, String password);

  Future<void> saveLocally(UserModel userModel);

  Future<UserModel?> findLocally();
}
