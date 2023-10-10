class PagingDto<T> {
  List<T> datas = [];
  int totalMount = 0;
  int totalCount = 0;

  PagingDto.optional({required this.datas, required this.totalMount, required this.totalCount});

  PagingDto() {
    datas = [];
    totalMount = 0;
    totalCount = 0;
  }

}


  