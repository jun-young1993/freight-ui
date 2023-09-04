import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class AppRouteMap {
  static List<Routes> getShowMenu(){
    return [
      Routes.drive,
      Routes.expenditure,
      Routes.oil,
      Routes.maintenance
    ];
  }

  static String getName(Routes routes){
    switch(routes){
      case Routes.home:
        return '홈';
      case Routes.drive:
        return '운행일지';
      case Routes.expenditure:
        return '지출내역';
      case Routes.oil:
        return '주유 내역';
      case Routes.maintenance:
        return '정비 내역';
      default :
        return 'no name';
    }
  }
}