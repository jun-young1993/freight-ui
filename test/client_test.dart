import 'dart:developer';


import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/utills/date.dart';
import 'package:test/test.dart';

void main() {
  group('freight client', (){
    test('should get drive to request ', () async {
      final freightClient = FreightClient();
      final response = await freightClient.get('/api/v1/operate');
      print(response.statusCode);
      print(response.body);
    });
    

  });
}
