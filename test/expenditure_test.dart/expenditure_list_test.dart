import 'dart:convert';
import 'dart:developer';
import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
    test('expenditure post list test ', () async {
      final url =Uri.parse('http://158.180.82.177:3000/api/v1/spend');
      final Map<String,String> headers = {
        'Authorization': 
            'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWU4YjIyNy1mYjBhLTRjOTktYjZhNy0yOGNjOTUyODdjY2QiLCJ1c2VyX2lkIjoiNWFlOGIyMjctZmIwYS00Yzk5LWI2YTctMjhjYzk1Mjg3Y2NkIiwibmFtZSI6ImdldXN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImNvbnRhY3QiOiJjb250YWN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImlhdCI6MTY5NTI4MDE3MiwiZXhwIjoyMDEwNjQwMTcyfQ.DxFZEZvORuP1LkvYQVTuRpuddyLiyVaxhIPpuRxDg5Q',
          'Content-Type': 'application/json',
      };
      // final msg = jsonEncode(data);
      final page = 1;
      final size = 10;
      final date = '2023-09-01';

      final uri = Uri.parse('$url?page=$page&size=$size&date=$date');

      print(' url : $uri');

      final response = await http.get(uri,headers: headers);
      final result_data = jsonDecode(utf8.decode(response.bodyBytes));

      print(result_data);

      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(result_data['data']);
      final List<ExpenditureDto> expenditureList = data
        .map((json) => ExpenditureDto.fromJson(json))
        .toList();

      for (var expenditure in expenditureList) {
        print('ID: ${expenditure.id}');
        print('userId: ${expenditure.userId}');
        print('price: ${expenditure.price}');
        print('paymentDetail: ${expenditure.paymentDetail}');
        print('createdAt: ${expenditure.createdAt}');
        print('extra: ${expenditure.extra}');
        print('Payment Date: ${expenditure.paymentDate}');
      }
    });
}


