
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/domain/excel.dart';
import 'package:freight_ui/repositories/common_repository.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:freight_ui/states/drive/drive_event.dart';
import 'package:freight_ui/states/drive/drive_state.dart';
import 'package:freight_ui/utills/date.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class DriveBloc extends Bloc<DriveEvent, DriveState> {
  final DriveRepository _driveRepository;
  final CommonRepository _commonRepository;
  DriveBloc(this._driveRepository,this._commonRepository) : super(DriveState.initial()) {
    on<DriveLoadStarted>(_onLoadStarted);
    on<DriveCreated>(_onCreated);
    on<DriveExcelDownload>(_onExcelDownload);
    on<DriveUpdated>(_onUpdated);
    on<DriveDeleted>(_onDeleted);
    on<DriveSelectedDateChanged>(_onSelectedDateChanged);
    on<DrivePageChanged>(_onPageChanged);
  }

  void _onLoadStarted(DriveLoadStarted event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      
      final data = await _driveRepository.get(
        queryParameters: {
          "date": CurrentDate('yyyy-MM-dd',dateTime: state.selectedDate),
          "page" : state.page.toString(),
          "size" : state.size.toString()
        }
      );
      print(data['data']);
      emit(state.asLoadSuccess(
          data['data'],
          totalCount: data['totalCount'],
          canLoadMore: false,
      ));
      
    } on Exception catch (e) {

      emit(state.asLoadFailure(e));
    }
  }

  void _onSelectedDateChanged(DriveSelectedDateChanged event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());

      final data = await _driveRepository.get(
          queryParameters: {
            "date": CurrentDate('yyyy-MM-dd',dateTime: event.selectedDate),
            "page" : 1.toString(),
            "size" : state.size.toString()
          }
      );

      emit(state.asLoadSuccess(data['data'], canLoadMore: false, selectedDate: event.selectedDate));

    } on Exception catch (e) {
      print(e);
      emit(state.asLoadFailure(e));
    }
  }

  void _onPageChanged(DrivePageChanged event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());

      final data = await _driveRepository.get(
          queryParameters: {
            "date" : CurrentDate('yyyy-MM-dd',dateTime: state.selectedDate),
            "page" : event.page.toString(),
            "size" : state.size.toString()
            // "2023-10-08"
          }
      );

      emit(state.asLoadSuccess(data['data'], canLoadMore: false, page: event.page, totalCount: data['totalCount'],));

    } on Exception catch (e) {
      print(e);
      emit(state.asLoadFailure(e));
    }
  }

  void _onCreated(DriveCreated event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      
      final DriveDto driveDto = event.drive;
      final drive = await _driveRepository.create(driveDto);
      state.data.insert(0,drive);

      emit(state.asLoadSuccess(state.data, canLoadMore: false));

    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onUpdated(DriveUpdated event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());

      final DriveDto driveDto = event.drive;
      final int driveId = event.id;
      final dataIndex = state.data.indexWhere(
            (data) => data.id == driveId,
      );
      final drive = await _driveRepository.update(driveId, driveDto);

      state.data[dataIndex] = drive;

      emit(state.asLoadSuccess(state.data, canLoadMore: false));

    } on Exception catch (e) {
      print(e);
      emit(state.asLoadFailure(e));
    }
  }

  void _onDeleted(DriveDeleted event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      final int driveId = event.id;
      final int dataIndex = state.data.indexWhere(
            (data) => data.id == driveId,
      );



      final result = await _driveRepository.delete(driveId);
      print(result);
      if(result == true){
        state.data.removeAt(dataIndex);
      }



      emit(state.asLoadSuccess(state.data, canLoadMore: false));

    } on Exception catch (e) {
      print(e);
      emit(state.asLoadFailure(e));
    }
  }

  void _onExcelDownload(DriveExcelDownload event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      print('drive download');

      final List<Drive> drives  =await _commonRepository.getExcelDataByDrive(
        CurrentDate(
          (event.type == ExcelDownloadItems.YearItem) ? 'yyyy' : 'yyyy-MM',
        state.selectedDate)
      );

  

      final Excel excel = Excel.createExcel();
      final Sheet sheet = excel['Sheet1'];
      
      sheet.appendRow([
        '상차일',
        '상차지',
        '하차일',
        '하차지'
      ]);
      for(var item in drives){
        sheet.appendRow([
          item.loadingDate,
          item.loadingPlace,
          item.unloadingDate,
          item.unloadingPlace,
        ]);
      }

      var fileBytes = excel.save();




      Directory directory = await getApplicationDocumentsDirectory();
  //     var storageStatus = await Permission.storage.status;
  // if (!storageStatus.isGranted) {
  //   await Permission.storage.request();
  // }
      print(join(directory.path,'output_file_name.xlsx'));
      File(join(directory.path,'output_file_name.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e) {
      print(e);
      emit(state.asLoadFailure(e));
    }
  }
  
}