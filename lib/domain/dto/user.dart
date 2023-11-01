import 'dart:convert';

class UserDto {
  final String id;
  final String contact;
  final String email;
  final String name;
  final String? extra;

  const UserDto({
    required this.id,
    required this.contact,
    required this.email,
    required this.name,
    this.extra
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['userId'] != null ? "${json['userId']}" : "${json['id']}",
      contact: "${json['contact']}",
      email: "${json['email']}",
      name: "${json['name']}",
      extra: "${json['extra']}",
    );
  }

  String toJson(){
    final Map<String, dynamic> data = {
      'id': id,
      'userId': id,
      'contact': contact,
      'email': email,
      'name': name,
      'extra': extra
    };
    return jsonEncode(data);
  }
}