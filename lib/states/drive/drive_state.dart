
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/utills/date.dart';

enum DriveStateStatus {
  initial,
  loading,
  createSuccess,
  loadSuccess,
  loadFailure
}


class DriveState {
  final DriveStateStatus status;
  final List<Drive> data;
  final int selectedIndex;
  final DateTime selectedDate;
  final int page;
  final int size;
  final bool canLoadMore;
  final Exception? error;



  const DriveState._({
    this.status = DriveStateStatus.initial,
    this.data = const [],
    this.selectedIndex = 0,
    required this.selectedDate,
    this.page = 1,
    this.size = 5,
    this.canLoadMore = true,
    this.error
  });

  DriveState.initial() : this._(
    selectedDate: DateTime.now()
  );

  DriveState asLoading(){
    return copyWith(
      status: DriveStateStatus.loading
    );
  }

  DriveState asCreated(){
    return copyWith(
        status: DriveStateStatus.createSuccess
    );
  }

  DriveState asLoadSuccess(List<Drive> data, {bool canLoadMore = true, DateTime? selectedDate, int? size, int? page}) {
    return copyWith(
      status: DriveStateStatus.loadSuccess,
      data: data,
      page: page ?? this.page,
      size: size ?? this.size,
      selectedDate: selectedDate ?? this.selectedDate,
      canLoadMore: canLoadMore
    );
  }

  DriveState asLoadFailure(Exception e){
    return copyWith(
      status: DriveStateStatus.loadFailure,
      error: e
    );
  }


  DriveState copyWith({
    DriveStateStatus? status,
    List<Drive>? data,
    int? selectedIndex,
    int? page,
    bool? canLoadMore,
    Exception? error,
    DateTime? selectedDate,
    int? size
  }) {
    return DriveState._(
        status: status ?? this.status,
        data: data ?? this.data,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        page: page ?? this.page,
        size: size ?? this.size,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        error: error ?? this.error,
        selectedDate: selectedDate ?? this.selectedDate
    );
  }
}

