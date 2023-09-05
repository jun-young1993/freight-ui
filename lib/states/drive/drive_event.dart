abstract class DriveEvent {
  const DriveEvent();
}

class DriveLoadStarted extends DriveEvent {
  final bool loadAll;

  const DriveLoadStarted({this.loadAll = false});
}

