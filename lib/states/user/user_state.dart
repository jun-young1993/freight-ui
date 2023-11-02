import 'package:freight_ui/domain/entities/user.dart';
import 'package:freight_ui/states/user/user_event.dart';

enum UserStateStatus {
  initial,
  login,
  loginSuccess,
  loginFailure
}

class UserState {
  final UserStateStatus status;
  final Exception? error;
  final User? user;
  final String? token;

  UserState._({
    this.status = UserStateStatus.initial,
    this.user,
    this.error,
    this.token
  });

  UserState.initial() : this._();

  UserState asLogin(){
    return copyWith(
      status: UserStateStatus.login
    );
  }

  UserState asLoginSuccess(User? user, String? token){
    return copyWith(
      user: user,
      token: token,
      status: UserStateStatus.loginSuccess
    );
  }

  UserState asLoginFailure(Exception e){
    return copyWith(
      status: UserStateStatus.loginFailure,
      error: e
    );
  }

  UserState copyWith({
    UserStateStatus? status,
    User? user,
    String? token,
    Exception? error
  }) {
    
    return UserState._(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      token: token ?? this.token
    );
  }

}