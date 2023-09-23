import 'package:freight_ui/domain/dto/drive.dart';

class Drive {
  final DateTime loadingDate;
  final String loadingPlace;
  final DateTime unLoadingDate;
  final String unLoadingPlace;
  final int loadingRatio;
  final int transportationCosts;
  final DateTime transportationDate;
  final String transportationType;
  final int unitCost;
  final String extra;

  const Drive({
    required this.loadingDate,
    required this.loadingPlace,
    required this.unLoadingDate,
    required this.unLoadingPlace,
    required this.loadingRatio,
    required this.transportationCosts, 
    required this.transportationDate,
    required this.transportationType,
    required this.unitCost,
    required this.extra
  });

  factory Drive.fromDto(DriveDto driveDto){
      
    return Drive(
      loadingDate: driveDto.loadingDate, 
      loadingPlace: driveDto.loadingPlace, 
      unLoadingDate: driveDto.unLoadingDate, 
      unLoadingPlace: driveDto.unLoadingPlace, 
      loadingRatio: driveDto.loadingRatio, 
      transportationCosts: driveDto.transportationCosts,
      transportationDate: driveDto.transportationDate, 
      transportationType: driveDto.transportationType, 
      unitCost: driveDto.unitCost, 
      extra: driveDto.extra, 
    );
  }
}