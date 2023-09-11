import 'dart:developer';


import 'package:freight_ui/utills/date.dart';
import 'package:test/test.dart';

void main() {
  group('utill', (){
    test('should searchDateTime to paring ', () {
      final currentDateTime = DateTime.now();
      
      expect(SearchDate(SearchDateType.start).toString().endsWith('00:00:00.000'), equals(true));
      expect(SearchDate(SearchDateType.end).toString().endsWith('23:59:59.000'), equals(true));
      expect(SearchDate(SearchDateType.start, dateTime: DateTime(2017, 9, 7)).toString(), equals("2017-09-07 00:00:00.000"));
      expect(SearchDate(SearchDateType.end, dateTime: DateTime(2017, 9, 7)).toString(), equals("2017-09-07 23:59:59.000"));

      final stringTime = "2023-09-14 12:34:56.000";
      final parseDateTime = DateTime.parse(stringTime);
      expect(SearchDate(SearchDateType.end, dateTime: parseDateTime).toString(), equals("2023-09-14 23:59:59.000"));
      expect(SearchDate(SearchDateType.start, dateTime: parseDateTime).toString(), equals("2023-09-14 00:00:00.000"));

    });



  });
}
