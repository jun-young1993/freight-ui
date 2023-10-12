import 'dart:convert';
import 'dart:io';

import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/user.dart';
import 'package:freight_ui/services/key_store_service.dart';

abstract class UserRepository {
  Future<void> guestLogin();
  Future<void> registration(UserDto userDto);
}

class UserDefaultRepository extends UserRepository {
  final _keyStoreService = KeyStoreService();
  final _freightClient = FreightClient();
  UserDefaultRepository();



  @override
  Future<void> guestLogin() async {
    await _keyStoreService.loginGuest();
  }

  @override
  Future<void> registration(UserDto userDto) async {
    
    final response = await _freightClient.post(
      '/api/v1/user/registration',
      body: userDto.toJson()
    );
    final int statusCode = response.statusCode;
    
    if((statusCode == HttpStatus.created) || (statusCode == HttpStatus.ok)){

      final Map<String, dynamic> body = json.decode(
          utf8.decode(response.bodyBytes)
      );
    }

      
  }
}