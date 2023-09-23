import 'dart:developer';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/services/key_store_service.dart';
import 'package:freight_ui/utills/date.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('freight client', (){
      late FreightClient freightClient;

      setUpAll(() async {
        await dotenv.load(fileName: './.env');
        final keyStoreService = KeyStoreService(storage: MockFlutterSecureStorage());
        // await keyStoreService.loginGuest();


        freightClient = FreightClient(keyStoreService: keyStoreService);


      });

    test('should get drive to request ', () async {

      final response = await freightClient.get('/api/v1/operate');

      // when(()=> freightClient.get('/api/v1/operate'));
      expect(response.statusCode, equals(200));
    });
    

  });
}
