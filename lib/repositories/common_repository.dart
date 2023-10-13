import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/domain/excel.dart';


abstract class CommonRepository {
  Future<Map<String, dynamic>> getExcelData(ExcelDownloadCategory category, String date);
  Future<List<Drive>> getExcelDataByDrive(String date);
}

class CommonDefaultRepository extends CommonRepository {
  final _freightClient = FreightClient();
  
  @override
  Future<Map<String, dynamic>> getExcelData(ExcelDownloadCategory category, String date) async {

      final response =
      await _freightClient.get('/api/v1/common/${describeEnum(category)}/${date}/excel');
      final int statusCode = response.statusCode;
      if((statusCode == HttpStatus.ok) || (statusCode == HttpStatus.noContent)){
        
        final Map<String, dynamic> body = json.decode(
            utf8.decode(response.bodyBytes)
        );
        return body;
      }

      throw Exception('Failed to get excel data: HTTP $statusCode category $category date $date');
  }

  @override
  Future<List<Drive>> getExcelDataByDrive(String date) async {
    final  Map<String, dynamic> body = await getExcelData(ExcelDownloadCategory.operate, date);
    final List<dynamic> driveData = body['data'];

    final List<Drive> result = [];
    for(var item in driveData){

      result.add(Drive.fromJson(item));
    }

    return result;

  }

}