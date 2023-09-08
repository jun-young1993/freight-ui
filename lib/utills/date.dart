enum SearchDateType {start, end}


DateTime SearchDate(SearchDateType type, { DateTime? dateTime }){
  final DateTime currentDate = dateTime ?? DateTime.now();
  final int year = currentDate.year;
  final int month = currentDate.month;
  final int day = currentDate.day;


  return DateTime(
    year,
    month,
    day,
    (type == SearchDateType.start) ? 0 : 23,
    (type == SearchDateType.start) ? 0 : 59,
    (type == SearchDateType.start) ? 0 : 59,
  );
}