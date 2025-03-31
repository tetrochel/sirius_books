sealed class UserEvent {}

class OnLoginPressed extends UserEvent {
  String password;
  String email;

  OnLoginPressed({
    required this.email,
    required this.password,
  });
}

class OnResetPasswordPressed extends UserEvent {
  String email;

  OnResetPasswordPressed({
    required this.email,
  });
}

class OnSighUpPressed extends UserEvent {}

class OnLogOutPressed extends UserEvent {}
