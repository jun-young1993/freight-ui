import 'dart:convert';

import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:http/http.dart' as http;

class ExpenditureBase {
  static String apiUri = 'http://158.180.82.177:3000';
  static String prefix = '/api/v1/spend';
  // Todo
  // Local Storage 또는 app 자체 스토리지 활용.
  static String Authorization = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YWU4YjIyNy1mYjBhLTRjOTktYjZhNy0yOGNjOTUyODdjY2QiLCJ1c2VyX2lkIjoiNWFlOGIyMjctZmIwYS00Yzk5LWI2YTctMjhjYzk1Mjg3Y2NkIiwibmFtZSI6ImdldXN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImNvbnRhY3QiOiJjb250YWN0XzVhZThiMjI3LWZiMGEtNGM5OS1iNmE3LTI4Y2M5NTI4N2NjZCIsImlhdCI6MTY5NTI4MDE3MiwiZXhwIjoyMDEwNjQwMTcyfQ.DxFZEZvORuP1LkvYQVTuRpuddyLiyVaxhIPpuRxDg5Q';
  static Map<String, String> headers = {
    "Authorization" : Authorization,
      'Content-Type': 'application/json',
  };
}

class ExpenditureService extends ExpenditureBase{
  // Todo
  // service code 리팩토링.
  Future<List<ExpenditureDto>> getExpenditureList(int page, int size, String date) async {
    
    List<ExpenditureDto> expenditureList = [];
    try {
      final getExpenditureListUri = Uri.parse('${ExpenditureBase.apiUri}${ExpenditureBase.prefix}?page=${page}&size=${size}&date=${date}');
      
      print('URL : ${getExpenditureListUri}' );
      final response = await http.get(getExpenditureListUri, headers: ExpenditureBase.headers);
      final resultData = jsonDecode(utf8.decode(response.bodyBytes));

      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(resultData['data']);
      expenditureList = data.map((json) => ExpenditureDto.fromJson(json)).toList();
      return expenditureList;
    } catch (e) { 
      print(e.toString());
      throw Exception ( 'Error: $e');
    }
    
  }

}