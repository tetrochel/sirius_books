import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sirius_books/features/user/data/model/user_model.dart';

class FirebaseUserDataSource {
  Future<UserModel?> login(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final role = userDoc.data()?['role'] == 'keeper'
          ? UserRole.keeper
          : UserRole.reader;

      final userModel = UserModel(
        email: userCredential.user!.email.toString(),
        role: role,
      );
      return userModel;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on Exception catch (_) {
      return;
    }
  }
}
