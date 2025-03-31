import 'package:sirius_books/features/user/data/data_source/firebase_user_data_source.dart';
import 'package:sirius_books/features/user/data/model/user.dart';
import 'package:sirius_books/features/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource firebaseUserDataSource;

  UserRepositoryImpl({
    required this.firebaseUserDataSource,
  });

  @override
  Future<UserModel?> login(String email, String password) async {
    return firebaseUserDataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    await firebaseUserDataSource.logout();
  }

  @override
  Future<void> resetPassword(String email) async {
    await firebaseUserDataSource.resetPassword(email);
  }
}
