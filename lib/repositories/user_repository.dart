import 'package:freight_ui/services/key_store_service.dart';

abstract class UserRepository {
  Future<void> guestLogin();
}

class UserDefaultRepository extends UserRepository {
  final _keyStoreService = KeyStoreService();

  UserDefaultRepository();



  @override
  Future<void> guestLogin() async {
    await _keyStoreService.loginGuest();
  }
}