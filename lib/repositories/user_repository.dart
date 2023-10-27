import 'dart:convert';
import 'dart:io';

import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/user.dart';
import 'package:freight_ui/services/key_store_service.dart';

abstract class UserRepository {
  Future<String> getToken();
  Future<void> guestLogin();
  Future<UserDto> registration(UserDto userDto);
}

class UserDefaultRepository extends UserRepository {
  final _keyStoreService = KeyStoreService();
  final _freightClient = FreightClient();
  UserDefaultRepository();

  @override
  Future<String> getToken() async {
    return await _keyStoreService.getAuthToken();
  } 

  @override
  Future<void> guestLogin() async {
    // final response = await _freightClient.post(
    //   '/api/v1/user//non-member-registration',
    // );

    // final int statusCode = response.statusCode;
    // if(statusCode == HttpStatus.ok){
      
    // }else{
    //   throw Exception('Failed to guest login: HTTP $statusCode');
    // }
    await _keyStoreService.loginGuest();
  }

  @override
  Future<UserDto> registration(UserDto userDto) async {
    
    final response = await _freightClient.post(
      '/api/v1/user/registration',
      body: userDto.toJson()
    );
    final int statusCode = response.statusCode;
    print(statusCode);
    if((statusCode == HttpStatus.created) || (statusCode == HttpStatus.ok)){

      final Map<String, dynamic> body = json.decode(
          utf8.decode(response.bodyBytes)
      );
      return userDto;
    }else{
      throw Exception('Failed to create user: HTTP $statusCode');
    }
  }
}