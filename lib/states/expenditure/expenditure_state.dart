import 'package:freight_ui/domain/entities/expenditure.dart';

enum ExpenditureStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure
}

class ExpenditureState {
  final ExpenditureStateStatus status;
  final List<Expenditure> data;
  final int selectedIndex;
  final int page;
  final bool canLoadMore;
  final Exception? error;

  const ExpenditureState._({
    this.status = ExpenditureStateStatus.initial,
    this.data = const [],
    this.selectedIndex = 0,
    this.page = 0,
    this.canLoadMore = true,
    this.error
  });

  const ExpenditureState.initial() : this._();

   ExpenditureState asLoading(){
    return copyWith(
      status: ExpenditureStateStatus.loading
    );
  }

  ExpenditureState asLoadSuccess(List<Expenditure> data, {bool canLoadMore = true}) {
    return copyWith(
      status: ExpenditureStateStatus.loadSuccess,
      data: data,
      page: 1,
      canLoadMore: canLoadMore
    );
  }

  ExpenditureState asLoadFailure(Exception e){
    return copyWith(
      status: ExpenditureStateStatus.loadFailure,
      error: e
    );
  }


  ExpenditureState copyWith({
    ExpenditureStateStatus? status,
    List<Expenditure>? data,
    int? selectedIndex,
    int? page,
    bool? canLoadMore,
    Exception? error
  }) {
    return ExpenditureState._(
        status: status ?? this.status,
        data: data ?? this.data,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        page: page ?? this.page,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        error: error ?? this.error
    );
  }
}

