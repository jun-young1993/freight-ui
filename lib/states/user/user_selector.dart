import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/states/user/user_bloc.dart';
import 'package:freight_ui/states/user/user_state.dart';

class UserStateSelector<T> extends BlocSelector<UserBloc, UserState, T> {
  UserStateSelector({
    super.key,
    required T Function(UserState) selector,
    required Widget Function(T) builder,
  }) : super(
    selector: selector,
    builder: (_, value) => builder(value)
  );
}

class UserStateStatusSelector extends UserStateSelector<UserStateStatus> {
  UserStateStatusSelector(Widget Function(UserStateStatus) builder)
  : super(
    selector: (state) => state.status,
    builder: builder
  );
}