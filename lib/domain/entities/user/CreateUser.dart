import 'package:freight_ui/domain/entities/user.dart';

class CreateUser {
  final User user;
  final String token;

  const CreateUser({
    required this.user,
    required this.token
  });
}