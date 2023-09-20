import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class KeyStoreImplement {
  late FlutterSecureStorage storage;
}

class KeyStoreService extends KeyStoreImplement {
  @override
  final storage = const FlutterSecureStorage();
}