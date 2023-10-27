

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/dto/user.dart';
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
    on<Registration>(_onRegistration);
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
  
      await _userRepository.guestLogin();
      final String token = await _userRepository.getToken();
      
      
      
      emit(state.asLoginSuccess(User.guest(), token));
      
    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void _onRegistration(Registration event, Emitter<UserState> emit) async {
    try{
      
      final UserDto dto = event.dto;
      await _userRepository.registration(dto);
      
        await AppNavigator.push(Routes.home);
      

    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void _onUser(UserStateEvent event, Emitter<UserState> emit) async {
    try{
      final String token = await _userRepository.getToken();
      print('token s ${token}');
      emit(state.asLoginSuccess(User.guest(), token));
    } on Exception catch (e) {
      print(e);
    }
  }
}


