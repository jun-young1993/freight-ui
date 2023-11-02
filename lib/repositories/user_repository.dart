import 'dart:convert';
import 'dart:io';

import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/user.dart';
import 'package:freight_ui/domain/entities/user.dart';
import 'package:freight_ui/domain/entities/user/CreateUser.dart';
import 'package:freight_ui/services/key_store_service.dart';

abstract class UserRepository {
  Future<String?> getToken();
  Future<User?> getUser();
  Future<void> guestLogin();
  Future<CreateUser> registration(UserDto userDto);
}

class UserDefaultRepository extends UserRepository {
  final _keyStoreService = KeyStoreService();
  final _freightClient = FreightClient();
  UserDefaultRepository();

  @override
  Future<String?> getToken() async {
    return await _keyStoreService.getAuthToken();
  } 

  @override
  Future<User?> getUser() async {
    return await _keyStoreService.getuserInfo();
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
  Future<CreateUser> registration(UserDto userDto) async {
    
    final response = await _freightClient.post(
      '/api/v1/user/registration',
      body: userDto.toJson()
    );
    final int statusCode = response.statusCode;
    final headers = response.headers;
    if((statusCode == HttpStatus.created) || (statusCode == HttpStatus.ok)){
      final String bodyString = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> body = json.decode(
          bodyString
      );
      body['id'] = body['userId'];
      
      if(headers.containsKey('authorization') && (headers['authorization'] is String)){
          final String authToken = headers['authorization'] as String;
          final CreateUser createUser = CreateUser(
            user: User.fromJson(body), 
            token: authToken
          );
          
          await _keyStoreService.setAuthToken(authToken);
          await _keyStoreService.setUserInfo(bodyString);

          
          return createUser;
        
      }else{
        throw Exception('Failed to create user token empty');
      }

      
    }else{
      throw Exception('Failed to create user: HTTP $statusCode');
    }
  }
}