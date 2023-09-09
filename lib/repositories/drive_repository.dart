import 'dart:math';

import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';

abstract class DriveRepository {
  Future<List<Drive>> get();
  Future<Drive> update(Drive drive);
  Future<Drive> create(DriveDto dto);
}

class DriveDefaultRepository extends DriveRepository {
  DriveDefaultRepository();

  @override
  Future<Drive> create(DriveDto dto) async {
    return const Drive(
        loadingDate: "20210101",
        loadingPlace: "test",
        unLoadingDate: "20210101",
        unLoadingPlace: "test2",
        loadingRatio: 100,
        transportationDate: "20210101",
        transportationType: "11톤",
        unitCost: 100000,
        extra: "test 데티어"

    );
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
          transportationDate: "20210101",
          transportationType: "11톤",
          unitCost: 100000,
          extra: "test 데티어"
    ));
    }
    return data;
  }

  @override
  Future<Drive> update(Drive drive) async {
        return const Drive(
            loadingDate: "20210101",
            loadingPlace: "test",
            unLoadingDate: "20210101",
            unLoadingPlace: "test2",
            loadingRatio: 100,
            transportationDate: "20210101",
            transportationType: "11톤",
            unitCost: 100000,
            extra: "test 데티어"
    );
  }
}