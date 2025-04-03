import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius_books/features/user/data/model/user_model.dart';

class LocalUserDataSource {
  Future<UserModel?> findUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail');
    final userRole = prefs.getString('userRole');
    if (userEmail != null && userRole != null) {
      return UserModel(email: userEmail, role: (userRole == 'keeper') ? UserRole.keeper : UserRole.reader);
    } else {
      return null;
    }
  }

  Future<void> saveUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', userModel.email);
    final role = (userModel.role == UserRole.keeper) ? 'keeper' : 'reader';
    await prefs.setString('userRole', role);
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userRole');
  }
}