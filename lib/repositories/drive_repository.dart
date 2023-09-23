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
  Future<List<Drive>> get();
  // Future<Drive> update(Drive drive);
  // Future<Drive> create(DriveDto dto);
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
  Future<List<Drive>> get() async {

    final response =
    await _freightClient.get('/api/v1/operate',
        queryParameters: {
          "date": "2023-09-14"
        }
    );

    final int statusCode = response.statusCode;
    final List<Drive> result = [];

    if((statusCode == HttpStatus.ok) || (statusCode == HttpStatus.noContent)){

      final Map<String, dynamic> body = json.decode(
          utf8.decode(response.bodyBytes)
      );

      final List<dynamic> data = body['data'];
      for(var item in data){
        result.add(Drive.fromJson(item));
      }
    };

    return result;
  }

  // @override
  // Future<Drive> update(Drive drive) async {
  //       return drive;
  // }

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