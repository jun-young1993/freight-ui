import 'dart:developer';

import 'package:freight_ui/core/utills.dart';
import 'package:test/test.dart';

void main() {
  group('utill', (){
    test('is http to string', () {
      
      expect(isHttp('http://localhost'), equals(true));
      expect(isHttp('https://localhost'), equals(false));
    });
  });
}
