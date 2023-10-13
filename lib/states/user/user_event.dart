import 'package:freight_ui/domain/dto/user.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  const UserLogin();
}

class GuestLogin extends UserEvent {
  const GuestLogin();
}

class Registration extends UserEvent {
  final UserDto dto;
  Registration(this.dto);
}

class UserStateEvent extends UserEvent {
  const UserStateEvent();
}
