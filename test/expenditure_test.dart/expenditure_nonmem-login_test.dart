import 'dart:developer';
import 'package:freight_ui/core/freight_client.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
    test('non member login ', () async {
      final url =Uri.parse('http://158.180.82.177:3000/api/v1/user/non-member-registration');
      final response = await http.post(url);

      print(response.statusCode);
      print(response.body);
      print(response.headers);
      // header에 Jwt value 있음.
      // jwt val : 
      // eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWU4YjIyNy1mYjBhLTRjOTktYjZhNy0yOGNjOTUyODdjY2QiLCJ1c2VyX2lkIjoiNWFlOGIyMjctZmIwYS00Yzk5LWI2YTctMjhjYzk1Mjg3Y2NkIiwibmFtZSI6ImdldXN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImNvbnRhY3QiOiJjb250YWN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImlhdCI6MTY5NTI4MDE3MiwiZXhwIjoyMDEwNjQwMTcyfQ.DxFZEZvORuP1LkvYQVTuRpuddyLiyVaxhIPpuRxDg5Q
    });
}
