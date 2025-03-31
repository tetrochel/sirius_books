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

class OnSignUpPressed extends UserEvent {}

class OnLogOutPressed extends UserEvent {}
