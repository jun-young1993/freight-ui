import 'dart:io';

import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/domain/entities/expenditure.dart';

abstract class ExpenditureRepository {
  Future<List<Expenditure>> get();
  Future<Expenditure> update(Expenditure expenditure);
  Future<Expenditure> create(ExpenditureDto expenditureDto);
  Future<bool> downExcel();
}

class ExpenditureRepositoryImpl extends ExpenditureRepository {
  ExpenditureRepositoryImpl();
  
  @override
  Future<Expenditure> create(ExpenditureDto expenditureDto) {
    return Future.value(Expenditure.fromDto(expenditureDto));
  }

  @override
  Future<bool> downExcel() {
    // TODO: implement downExcel
    throw UnimplementedError();
  }
  
  @override
  Future<List<Expenditure>> get() {
    throw UnimplementedError();
  }
  
  @override
  Future<Expenditure> update(Expenditure expenditure) {
    return  Future.value(expenditure);
  }

}