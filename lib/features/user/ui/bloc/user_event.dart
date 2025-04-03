import 'package:sirius_books/features/user/data/model/user_model.dart';

sealed class UserEvent {}

class OnLoginPressed extends UserEvent {
  final String password;
  final String email;

  OnLoginPressed({
    required this.email,
    required this.password,
  });
}

class OnResetPasswordPressed extends UserEvent {
  final String email;

  OnResetPasswordPressed({
    required this.email,
  });
}

class OnSignUpPressed extends UserEvent {
  final String email;
  final String password;

  OnSignUpPressed({
    required this.email,
    required this.password,
  });
}

class OnLogOutPressed extends UserEvent {}

class OnFindLocally extends UserEvent {}

class OnSaveLocally extends UserEvent {
  final UserModel userModel;

  OnSaveLocally({
    required this.userModel,
  });
}
