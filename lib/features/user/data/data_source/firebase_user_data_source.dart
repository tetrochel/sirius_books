import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sirius_books/features/user/data/model/user.dart';

class FirebaseUserDataSource {
  Future<UserModel?> login(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      late UserRole role;
      if (FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .get()
              .toString() ==
          "keeper") {
        role = UserRole.keeper;
      } else {
        role = UserRole.reader;
      }
      UserModel userModel = UserModel(
        email: userCredential.user!.email.toString(),
        role: role,
      );
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      return;
    }
  }
}
