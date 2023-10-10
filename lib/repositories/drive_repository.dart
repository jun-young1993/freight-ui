import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:freight_ui/core/freight_client.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class DriveRepository {
  Future<Map<String, dynamic>> get({Map<String, dynamic>? queryParameters});
  Future<Drive> update(int id, DriveDto dto);
  Future<Drive> create(DriveDto dto);
  Future<bool> delete(int id);
  Future<bool> downExcel(
    // List<Drive>? drives
    );
}

class DriveDefaultRepository extends DriveRepository {
  DriveDefaultRepository();

  final _freightClient = FreightClient();

  // @override
  // Future<Drive> create(DriveDto dto) async {
  //   // return Drive.fromDto(dto);
  // }

  @override
  Future<Map<String, dynamic>> get( {Map<String, dynamic>? queryParameters}) async {

    final response =
    await _freightClient.get('/api/v1/operate',
        queryParameters: queryParameters
    );

    final int statusCode = response.statusCode;

    late int totalCount = 0;
    final Map<String, dynamic> result = {
      'data' : <Drive>[],
      'totalCount' : totalCount
    };

    if((statusCode == HttpStatus.ok) || (statusCode == HttpStatus.noContent)){
      final String decodeUtf8 = utf8.decode(response.bodyBytes);
      if(decodeUtf8.isNotEmpty){
        final Map<String, dynamic> body = json.decode(
            decodeUtf8
        );

        final List<dynamic> driveData = body['data'];
        totalCount = body['totalCount'];

        for(var item in driveData){

          result['data'].add(Drive.fromJson(item));
        }
        result['totalCount'] = body['totalCount'];
      }

    };

    return result;
  }

  @override
  Future<Drive> create(DriveDto dto) async {

    final response =
    await _freightClient.post(
      '/api/v1/operate',
      body: dto.toJson()
    );
    final int statusCode = response.statusCode;
    // ?? post 201 만 쓰자..
    if((statusCode == HttpStatus.created) || (statusCode == HttpStatus.ok)){

      final Map<String, dynamic> body = json.decode(
          utf8.decode(response.bodyBytes)
      );

      return Drive.fromJson(body);
    }else{
       throw Exception('Failed to create DriveDto: HTTP $statusCode');
    }

  }

  @override
  Future<Drive> update(int id, DriveDto dto) async {


    final body = jsonDecode(dto.toJson());
    body['id'] = id;

    final response =
    await _freightClient.put(
        '/api/v1/operate',
        body: jsonEncode(body)
    );
    final int statusCode = response.statusCode;
    // ?? post 201 만 쓰자..
    if((statusCode == HttpStatus.ok)){

      final Map<String, dynamic> body = json.decode(
          utf8.decode(response.bodyBytes)
      );

      return Drive.fromJson(body);
    }else{
      throw Exception('Failed to updated DriveDto: HTTP $statusCode');
    }

  }

  @override
  Future<bool> delete(int id) async {




    final response =
    await _freightClient.delete(
        "/api/v1/operate/${id}"
    );
    final int statusCode = response.statusCode;
    // ?? post 201 만 쓰자..
    if((statusCode == HttpStatus.ok)){

      return true;
    }else{
      throw Exception('Failed to deleted DriveDto: HTTP $statusCode');
    }

  }

  @override
  Future<bool> downExcel(
    // List<Drive> drives
    ) async {
    final excelService = ExcelService();
          final Excel excel = excelService.create();
      final Sheet sheet = excel['Sheet1'];
      
      sheet.appendRow(['Flutter', 'till', 'Eternity']);
      var fileBytes = excel.save();
      Directory directory = await getApplicationDocumentsDirectory();
      
      print(join(directory.path,'output_file_name.xlsx'));
      File(join(directory.path,'output_file_name.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
    return true;
  }
}