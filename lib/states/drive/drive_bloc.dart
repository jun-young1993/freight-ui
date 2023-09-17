import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:freight_ui/states/drive/drive_event.dart';
import 'package:freight_ui/states/drive/drive_state.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DriveBloc extends Bloc<DriveEvent, DriveState> {
  final DriveRepository _driveRepository;
  DriveBloc(this._driveRepository) : super(const DriveState.initial()) {
    on<DriveLoadStarted>(_onLoadStarted);
    on<DriveCreated>(_onCreated);
    on<DriveExcelDownload>(_onExcelDownload);
  }

  void _onLoadStarted(DriveLoadStarted event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      final data = await _driveRepository.get();
      // inspect(data);
      emit(state.asLoadSuccess(data, canLoadMore: false));
      
    } on Exception catch (e) {
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

  void _onExcelDownload(DriveExcelDownload event, Emitter<DriveState> emit) async {
    try{
      emit(state.asLoading());
      print('drive download');
      final drive = await _driveRepository.downExcel();

      emit(state.asLoadSuccess(state.data, canLoadMore: false));
    } on Exception catch (e) {
      
      emit(state.asLoadFailure(e));
    }
  }
  
}