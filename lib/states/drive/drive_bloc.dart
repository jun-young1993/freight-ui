import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/states/drive/drive_event.dart';
import 'package:freight_ui/states/drive/drive_state.dart';

class DriveBloc extends Bloc<DriveEvent, DriveState> {
  final DriveRepository _driveRepository;
  DriveBloc(this._driveRepository) : super(DriveState.initial()) {
    on<DriveLoadStarted>(_onLoadStarted);
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


    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  
}