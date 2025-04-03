import 'package:sirius_books/features/user/data/data_source/firebase_user_data_source.dart';
import 'package:sirius_books/features/user/data/data_source/local_user_data_source.dart';
import 'package:sirius_books/features/user/data/model/user_model.dart';
import 'package:sirius_books/features/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource firebaseUserDataSource;
  final LocalUserDataSource localUserDataSource;

  UserRepositoryImpl({
    required this.firebaseUserDataSource,
    required this.localUserDataSource,
  });

  @override
  Future<UserModel?> login(String email, String password) async {
    return firebaseUserDataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    await firebaseUserDataSource.logout();
    await localUserDataSource.deleteUser();
  }

  @override
  Future<void> resetPassword(String email) async {
    await firebaseUserDataSource.resetPassword(email);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await firebaseUserDataSource.signUp(email, password);
  }

  @override
  Future<void> saveLocally(UserModel userModel) async {
    await localUserDataSource.saveUser(userModel);
  }

  @override
  Future<UserModel?> findLocally() async {
    return localUserDataSource.findUser();
  }
}
