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

class DriveExcelDownload extends DriveEvent {
  const DriveExcelDownload();
}

