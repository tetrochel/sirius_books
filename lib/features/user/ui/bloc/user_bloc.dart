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
        case OnSighUpPressed():
          await _handleSignUpPressed(event, emit);
        case OnLogOutPressed():
          await _handleLogOutPressed(event, emit);
        case OnResetPasswordPressed():
          await _handleResetPasswordPressed(event, emit);
      }
    });
  }

  Future<void> _handleLoginPressed(OnLoginPressed event, Emitter<UserState> emit) async {
    try {
      final user = await userRepository.login(
        event.email,
        event.password,
      );
      emit(UserState()..userModel = user);
      //navigationController.showSnackBar(state.userModel!.role.toString());
    } catch (e) {
      navigationController.showSnackBar(e.toString());
    }
  }

  Future<void> _handleSignUpPressed(OnSighUpPressed event, Emitter<UserState> emit) async {

  }

  Future<void> _handleLogOutPressed(OnLogOutPressed event, Emitter<UserState> emit) async {
    try {
      await userRepository.logout();
      emit(UserState()..userModel = null);
    } catch (e) {
      navigationController.showSnackBar(e.toString());
    }
  }

  Future<void> _handleResetPasswordPressed(OnResetPasswordPressed event,Emitter<UserState> emit) async {
    try {
      await userRepository.resetPassword(event.email);
    } catch (e) {
      navigationController.showSnackBar(e.toString());
    }
  }
}
