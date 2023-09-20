import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/entities/user.dart';
import 'package:freight_ui/repositories/user_repository.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/user/user_event.dart';
import 'package:freight_ui/states/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserState.initial()) {
    on<UserLogin>(_onUserLogin);
    on<GuestLogin>(_onGuestLogin);
    on<SignUp>(_onSignUp);
    on<UserStateEvent>(_onUser);
  }

  void _onUserLogin(UserLogin event, Emitter<UserState> emit) async {
    try{
      emit(state.asLogin());
      await AppNavigator.push(Routes.authLogin);
      // emit(state.asLoginSuccess());
    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void _onGuestLogin(GuestLogin event, Emitter<UserState> emit) async {
    try{
      emit(state.asLogin());
      await AppNavigator.push(Routes.home);
      
      emit(state.asLoginSuccess(User.guest()));
    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void _onSignUp(SignUp envet, Emitter<UserState> emit) async {
    try{
      await AppNavigator.push(Routes.signUp);
    } on Exception catch (e) {

    }
  }

  void _onUser(UserStateEvent event, Emitter<UserState> emit) async {
    try{

    } on Exception catch (e) {

    }
  }
}