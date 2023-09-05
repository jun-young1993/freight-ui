
import 'package:freight_ui/domain/entities/drive.dart';

enum DriveStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure
}


class DriveState {
  final DriveStateStatus status;
  final List<Drive> data;
  final int selectedIndex;
  final int page;
  final bool canLoadMore;
  final Exception? error;

  const DriveState._({
    this.status = DriveStateStatus.initial,
    this.data = const [],
    this.selectedIndex = 0,
    this.page = 0,
    this.canLoadMore = true,
    this.error
  });

  const DriveState.initial() : this._();

  DriveState asLoading(){
    return copyWith(
      status: DriveStateStatus.loading
    );
  }

  DriveState asLoadSuccess(List<Drive> data, {bool canLoadMore = true}) {
    return copyWith(
      status: DriveStateStatus.loadSuccess,
      data: data,
      page: 1,
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
    Exception? error
  }) {
    return DriveState._(
        status: status ?? this.status,
        data: data ?? this.data,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        page: page ?? this.page,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        error: error ?? this.error
    );
  }
}

