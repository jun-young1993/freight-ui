class PagingDto<T> {
  List<T> datas;
  int totalMount;
  int totalCount;

  PagingDto.optional({required this.datas, required this.totalMount, required this.totalCount});
}


  