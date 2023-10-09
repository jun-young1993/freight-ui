import 'package:freight_ui/domain/dto/drive.dart';

abstract class DriveEvent {
  const DriveEvent();
}

class DriveLoadStarted extends DriveEvent {
  final bool loadAll;

  const DriveLoadStarted({this.loadAll = false});
}

class DriveCreated extends DriveEvent {
  final DriveDto drive;
  const DriveCreated(this.drive);
}

class DriveUpdated extends DriveEvent {
  final DriveDto drive;
  final int id;
  const DriveUpdated(this.id, this.drive);
}

class DriveDeleted extends DriveEvent {
  final int id;
  const DriveDeleted(this.id);
}

class DriveSelectedDateChanged extends DriveEvent {
  final DateTime selectedDate;
  DriveSelectedDateChanged(this.selectedDate);
}

class DrivePageChanged extends DriveEvent {
  final int page;
  DrivePageChanged(this.page);
}

class DriveExcelDownload extends DriveEvent {
  const DriveExcelDownload();
}

