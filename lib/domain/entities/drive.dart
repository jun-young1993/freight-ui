import 'dart:ffi';

import 'package:freight_ui/domain/dto/drive.dart';

class Drive {
  final int id;
  final String userId;
  final DateTime loadingDate;
  final String loadingPlace;
  final DateTime unLoadingDate;
  final String unLoadingPlace;
  final int loadingRatio;
  final int transportationCosts;
  final DateTime transportationDate;
  final String transportationType;
  final int unitCost;
  // final String extra;
  final DateTime createdAt;


  const Drive({
    required this.id,
    required this.userId,
    required this.loadingDate,
    required this.loadingPlace,
    required this.unLoadingDate,
    required this.unLoadingPlace,
    required this.loadingRatio,
    required this.transportationCosts, 
    required this.transportationDate,
    required this.transportationType,
    required this.unitCost,
    // required this.extra,
    required this.createdAt,

  });

  factory Drive.fromJson(
      Map<String, dynamic> json
  ){
    return Drive(
      id: json['id'],
      userId: json['userId'],
      loadingDate: DateTime.parse(json['loadingDate']),
      loadingPlace: json['loadingPlace'],
      unLoadingDate: DateTime.parse(json['unloadingDate']),
      unLoadingPlace: json['unloadingPlace'],
      loadingRatio: json['loadingRatio'],
      transportationCosts: json['transportationCosts'],
      transportationDate: DateTime.parse(json['transportationDate']),
      transportationType: json['transportationType'],
      unitCost: json['unitCost'],
      // extra: json['extra'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }
}