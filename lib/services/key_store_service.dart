import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freight_ui/config/constant.dart';

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
  Future<void> loginGuest() async {
    try{
      await storage.write(
          key: userAuthToken,
          value: dotenv.get('GUEST_TOKEN')
      );
    }catch(e){
      print('Error while writing to secure storage: $e');
    }

  }

  Future<String> getAuthToken() async {
    String authToken = await storage.read(key: userAuthToken) ?? dotenv.get('GUEST_TOKEN');

    return authToken;
  }

  getReadAll() {
    return storage.readAll();
  }
}