abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  const UserLogin();
}

class GuestLogin extends UserEvent {
  const GuestLogin();
}