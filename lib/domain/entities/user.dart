import 'package:freight_ui/domain/dto/user.dart';

class User {
  final String id;
  final String contact;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.contact,
    required this.email,
    required this.name
  });

  factory User.guest(){
    return const User(
      id: "GUEST",
      contact: "GUEST",
      email: "GUEST",
      name: "GUEST"
    );
  }

  factory User.fromDto(UserDto userDto){
    return User(
      contact: userDto.contact,
      id: userDto.id, 
      email: userDto.email, 
      name: userDto.name
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User.fromDto(
      UserDto.fromJson(json)
    );
  }


}