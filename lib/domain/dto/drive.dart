

class DriveDto {
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

  const DriveDto({
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

  factory DriveDto.fromJson(Map<String, dynamic> json){
    return DriveDto(
      loadingDate: json['loadingDate'], 
      loadingPlace: json['loadingPlace'], 
      unLoadingDate: json['unLoadingDate'], 
      unLoadingPlace: json['unLoadingPlace'], 
      loadingRatio: int.parse(json['loadingRatio']), 
      transportationCosts: int.parse(json['transportationCosts']),
      transportationDate: json['transportationDate'], 
      transportationType: json['transportationType'], 
      unitCost: int.parse(json['unitCost']), 
      extra: json['extra'], 
    );
  }
}