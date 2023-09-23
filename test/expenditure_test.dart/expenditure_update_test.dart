import 'dart:convert';
import 'dart:developer';
import 'package:freight_ui/core/freight_client.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
    test('expenditure update test ', () async {
      final url =Uri.parse('http://158.180.82.177:3000/api/v1/spend');
      final Map<String,String> headers = {
        'Authorization': 
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWU4YjIyNy1mYjBhLTRjOTktYjZhNy0yOGNjOTUyODdjY2QiLCJ1c2VyX2lkIjoiNWFlOGIyMjctZmIwYS00Yzk5LWI2YTctMjhjYzk1Mjg3Y2NkIiwibmFtZSI6ImdldXN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImNvbnRhY3QiOiJjb250YWN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImlhdCI6MTY5NTI4MDE3MiwiZXhwIjoyMDEwNjQwMTcyfQ.DxFZEZvORuP1LkvYQVTuRpuddyLiyVaxhIPpuRxDg5Q',
          'Content-Type': 'application/json',
      };
      
      var data = {
        "id":"10",
        "extra": "비고 데이터 수정 ",
        "paymentDate": "2023-09-25",
        "paymentDetail": "11 톤 주유 했었는데 알고보니까 18톤이었네? 수정 ",
        "price":  100,
        "userId": "5ae8b227-fb0a-4c99-b6a7-28cc95287ccd"
      };
      
      final msg = jsonEncode(data);

      final response = await http.put(
        url,
        body: msg,
        headers: headers
      );

      print(response.statusCode);
      print(response.body);
      print(response.headers);

    });
}
