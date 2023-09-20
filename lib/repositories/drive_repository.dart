import 'dart:io';

import 'package:excel/excel.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract class DriveRepository {
  Future<List<Drive>> get();
  Future<Drive> update(Drive drive);
  Future<Drive> create(DriveDto dto);
  Future<bool> downExcel(
    // List<Drive>? drives
    );
}

class DriveDefaultRepository extends DriveRepository {
  DriveDefaultRepository();

  @override
  Future<Drive> create(DriveDto dto) async {
    return Drive.fromDto(dto);
  }

  @override
  Future<List<Drive>> get() async {
    final List<Drive> data = [];
    for(var index= 0; index<100; index++){
      
      data.add(const Drive(
          loadingDate: "20210101",
          loadingPlace: "test",
          unLoadingDate: "20210101",
          unLoadingPlace: "test2",
          loadingRatio: 100,
          transportationCosts: 100,
          transportationDate: "20210101",
          transportationType: "11톤",
          unitCost: 100000,
          extra: 'test 데티어 index'
    ));
    }
    return data;
  }

  @override
  Future<Drive> update(Drive drive) async {
        return drive;
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