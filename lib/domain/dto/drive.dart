class DriveDto {
  final String loadingDate;
  final String loadingPlace;
  final String unLoadingDate;
  final String unLoadingPlace;
  final int loadingRatio;
  final String transportationDate;
  final String transportationType;
  final int unitCost;
  final String extra;

  const DriveDto({
    required this.loadingDate,
    required this.loadingPlace,
    required this.unLoadingDate,
    required this.unLoadingPlace,
    required this.loadingRatio,
    required this.transportationDate,
    required this.transportationType,
    required this.unitCost,
    required this.extra
  });
}