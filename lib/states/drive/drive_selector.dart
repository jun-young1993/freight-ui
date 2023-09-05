import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/states/drive/drive_state.dart';

class DriveStateSelector<T> extends BlocSelector<DriveBloc, DriveState, T> {
  DriveStateSelector({
    required T Function(DriveState) selector,
    required Widget Function(T) builder,
  }) : super( 
    selector: selector,
    builder: (_, value) => builder(value)
  );
}

class DriveStateStatusSelector extends DriveStateSelector<DriveStateStatus> {
  DriveStateStatusSelector(Widget Function(DriveStateStatus) builder)
  : super(
    selector: (state) => state.status,
    builder: builder
  );
}

class DriveCountSelector extends DriveStateSelector<int> {
  DriveCountSelector(Widget Function(int) builder)
  : super(
    selector: (state) => state.data.length,
    builder: builder
  );
}

class DriveSelector extends DriveStateSelector<DriveSelectorState>{
  DriveSelector(int index, Widget Function(Drive, bool) builder)
  : super(
    selector: (state) => DriveSelectorState(
      state.data[index],
      state.selectedIndex == index
    ),
    builder: (value) => builder(value.drive, value.selected)
  );
}


class DriveSelectorState {
  final Drive drive;
  final bool selected;

  const DriveSelectorState(this.drive, this.selected);

  @override
  bool operator == (Object other) => 
    other is DriveSelectorState && drive == other.drive && selected == other.selected;
}