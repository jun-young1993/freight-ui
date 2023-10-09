

import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/utills/date.dart';

class DriveDto {
  final DateTime loadingDate;
  final String loadingPlace;
  final DateTime unloadingDate;
  final String unloadingPlace;
  final int loadingRatio;
  final int transportationCosts;
  final DateTime transportationDate;
  final String transportationType;
  final int unitCost;
  final String extra;

  const DriveDto({
    required this.loadingDate,
    required this.loadingPlace,
    required this.unloadingDate,
    required this.unloadingPlace,
    required this.loadingRatio,
    required this.transportationCosts, 
    required this.transportationDate,
    required this.transportationType,
    required this.unitCost,
    required this.extra
  });

  factory DriveDto.fromJson(Map<String, dynamic> json){

    return DriveDto(
      loadingDate: DateTime.parse(json['loadingDate']),
      loadingPlace: "${json['loadingPlace']}",
      unloadingDate: DateTime.parse(json['unloadingDate']),
      unloadingPlace: "${json['unloadingPlace']}",
      loadingRatio: int.parse("${json['loadingRatio']}"),
      transportationCosts: int.parse("${json['transportationCosts']}"),
      transportationDate: DateTime.parse(json['transportationDate']),
      transportationType: "${json['transportationType']}",
      unitCost: int.parse("${json['unitCost']}"),
      extra: "${json['extra']}",
    );
  }

  String toJson({bool encode = true}) {
    final Map<String, dynamic> data = {
      'loadingDate': CurrentDate("yyyy-MM-dd",dateTime: loadingDate),
      'loadingPlace': loadingPlace,
      'unloadingDate': CurrentDate("yyyy-MM-dd",dateTime: unloadingDate),
      'unloadingPlace': unloadingPlace,
      'loadingRatio': loadingRatio,
      'transportationCosts': transportationCosts,
      'transportationDate': CurrentDate("yyyy-MM-dd",dateTime: transportationDate),
      'transportationType': transportationType,
      'unitCost': unitCost,
      'extra': extra,
    };

    return jsonEncode(data);



  }
}