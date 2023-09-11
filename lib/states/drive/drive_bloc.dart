import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/states/drive/drive_event.dart';
import 'package:freight_ui/states/drive/drive_state.dart';

class DriveBloc extends Bloc<DriveEvent, DriveState> {
  final DriveRepository _driveRepository;
  DriveBloc(this._driveRepository) : super(const DriveState.initial()) {
    on<DriveLoadStarted>(_onLoadStarted);
    on<DriveCreated>(_onCreated);
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

  
}