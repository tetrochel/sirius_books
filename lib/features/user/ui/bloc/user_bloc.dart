import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/config/navigation/navigator_controller.dart';
import 'package:sirius_books/features/user/repository/user_repository.dart';
import 'package:sirius_books/features/user/ui/bloc/user_event.dart';
import 'package:sirius_books/features/user/ui/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final NavigationController navigationController;

  UserBloc({
    required this.userRepository,
    required this.navigationController,
  }) : super(UserState()) {
    on<UserEvent>((event, emit) async {
      switch (event) {
        case OnLoginPressed():
          await _handleLoginPressed(event, emit);
        case OnSignUpPressed():
          await _handleSignUpPressed(event, emit);
        case OnLogOutPressed():
          await _handleLogOutPressed(event, emit);
        case OnResetPasswordPressed():
          await _handleResetPasswordPressed(event, emit);
        case OnFindLocally():
          await _handleFindLocally(event, emit);
        case OnSaveLocally():
          await _handleSaveLocally(event, emit);
      }
    });
  }

  Future<void> _handleLoginPressed(
    OnLoginPressed event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserState()..isLoading = true);
      final user = await userRepository.login(
        event.email,
        event.password,
      );
      emit(UserState()..userModel = user..isLoading = false);
      await _handleSaveLocally(OnSaveLocally(userModel: state.userModel!), emit);

    } on FirebaseAuthException catch (e) {
      navigationController.showSnackBar('Ошибка аутентификации: ${e.message}');
    } on Exception catch (e) {
      navigationController.showSnackBar('Произошла ошибка: ${e.toString()}');
    }
  }

  Future<void> _handleSignUpPressed(
    OnSignUpPressed event,
    Emitter<UserState> emit,
  ) async {
    await userRepository.signUp(event.email, event.password);
  }

  Future<void> _handleLogOutPressed(
    OnLogOutPressed event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserState()..userModel = null);
      await userRepository.logout();
    } on FirebaseAuthException catch (e) {
      navigationController.showSnackBar('Ошибка выхода: ${e.message}');
    } on Exception catch (e) {
      navigationController.showSnackBar('Произошла ошибка: ${e.toString()}');
    }
  }

  Future<void> _handleResetPasswordPressed(
    OnResetPasswordPressed event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.resetPassword(event.email);
    } on FirebaseAuthException catch (e) {
      navigationController.showSnackBar('Ошибка сброса пароля: ${e.message}');
    } on Exception catch (e) {
      navigationController.showSnackBar('Произошла ошибка: ${e.toString()}');
    }
  }

  Future<void> _handleFindLocally(
    OnFindLocally event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = await userRepository.findLocally();
      emit(UserState()..userModel = user);
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleSaveLocally(
    OnSaveLocally event,
    Emitter<UserState> emit,
  ) async {
    try {
      await userRepository.saveLocally(event.userModel);
    } on Exception catch (_) {
      return;
    }
  }
}
