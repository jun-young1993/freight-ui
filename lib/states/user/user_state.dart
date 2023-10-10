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

  UserState._({
    this.status = UserStateStatus.initial,
    this.user,
    this.error
  });

  UserState.initial() : this._();

  UserState asLogin(){
    return copyWith({
      status: UserStateStatus.login
    });
  }

  UserState asLoginSuccess(User user){
    return copyWith({
      user: user,
      status: UserStateStatus.loginSuccess
    });
  }

  UserState asLoginFailure(Exception e){
    return copyWith({
      status: UserStateStatus.loginFailure,
      error: e
    });
  }

  UserState copyWith( map, {
    UserStateStatus? status,
    User? user,
    Exception? error
  }) {
    return UserState._(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error
    );
  }

}