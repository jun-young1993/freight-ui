import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/repositories/user_repository.dart';
import 'package:freight_ui/states/user/user_event.dart';
import 'package:freight_ui/states/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(const UserState.initial()) {
    on<UserLogin>(_onUserLogin);
    on<GuestLogin>(_onGuestLogin);
  }

  void _onUserLogin(UserLogin event, Emitter<UserState> emit) async {
    try{
      emit(state.asLogin());

      emit(state.asLoginSuccess());
    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void _onGuestLogin(GuestLogin event, Emitter<UserState> emit) async {
    try{
      emit(state.asLogin());

      emit(state.asLoginSuccess());
    } on Exception catch (e) {
      emit(state.asLoginFailure(e));
    }
  }
}