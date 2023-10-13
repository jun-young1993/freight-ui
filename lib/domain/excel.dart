enum ExcelDownloadCategory {
  operate
}

class ExcelDownloadItems {
  static const String YearItem = '연도별';
  static const String MonthItem = '월별';
  

  static const List<String> choices = <String>[
    YearItem,
    MonthItem,
  ];
}