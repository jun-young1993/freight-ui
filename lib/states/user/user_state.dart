enum UserStateStatus {
  initial,
  login,
  loginSuccess,
  loginFailure
}

class UserState {
  final UserStateStatus status;
  final Exception? error;

  const UserState._({
    this.status = UserStateStatus.initial,
    this.error
  });

  const UserState.initial() : this._();

  UserState asLogin(){
    return copyWith({
      status: UserStateStatus.login
    });
  }

  UserState asLoginSuccess(){
    return copyWith({
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
    Exception? error
  }) {
    return UserState._(
      status: status ?? this.status,
      error: error ?? this.error
    );
  }

}