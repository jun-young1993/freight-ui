import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/domain/entities/user.dart';

abstract class KeyStoreImplement {
  // late FlutterSecureStorage storage;
}

class KeyStoreService {
  final FlutterSecureStorage storage;

  KeyStoreService({
    FlutterSecureStorage this.storage = const FlutterSecureStorage(

    )
  });

  final String userAuthToken = "${AppConstant.name}-auth-token";
  final String userInfo = "${AppConstant.name}-user-info";
  Future<void> loginGuest() async {
    try{
      
      setAuthToken(dotenv.get('GUEST_TOKEN'));
    }catch(e){
      print('Error while writing to secure storage: $e');
    }

  }

  Future<void> setAuthToken(String value) async {

      await storage.write(
          key: userAuthToken,
          value: value
      );

  }

  Future<void> setUserInfo(String value) async {

      await storage.write(
          key: userInfo,
          value: value
      );
  }

  Future<String> getAuthToken() async {
    String authToken = await storage.read(key: userAuthToken) ?? dotenv.get('GUEST_TOKEN');

    return authToken;
  }

  Future<User?> getuserInfo() async {
    String? userData = await storage.read(key: userInfo);
    if(userData != null){
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

  getReadAll() {
    return storage.readAll();
  }
}