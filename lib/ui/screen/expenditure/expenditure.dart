import 'package:flutter/material.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/services/expenditure_service.dart';
import 'package:freight_ui/ui/widgets/form/calendar_year_month.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  /*
    1. 메인 화면 달력 선택 appBar
    2. 달 선택에 따른 검색 초기화.
    3. 검색 리스트 보여주기. body
    4. ios / galaxy 뒤로가기 버튼 막을 것. 
    5. 신규 등록 페이지
    6. 상세 페이지 X ? -> 수정 / 삭제 페이지로 넘어 가기 힘듦.
    7. 수정 - 페이지 - 삭제 버튼 추가.
  */
  List<ExpenditureDto> expenditureList = [];
  int itemCount = 30; // 전체 아이템 수
  int itemsPerPage = 10; // 페이지 당 아이템 수
  int currentPage = 0; // 현재 페이지

  @override
  void initState() {
    super.initState();
    loadExpenditureList();
  }

  Future<void> loadExpenditureList() async {
    try {
      final expenditureService = ExpenditureService();
      final result =
          await expenditureService.getExpenditureList(1, 10, '2023-09-01');
      setState(() {
        expenditureList = result;
        itemCount = result.totalMount;
      });
      print(' result : $result.data ');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('지출 내역'),
          // 햄버거 버튼 추가
          leading: Builder(
            builder: (BuildContext context) {
              return (Text(''));
            },
          ), 
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    print('추가 버튼 눌렀습니다.');
                  }, icon: Icon(Icons.add),),
                  SimpleCalendar(),
                  InkWell(
                    onTap: () {
                      print(' 엑셀 버튼 눌러씃ㅂ니다');
                    },
                    child: Image.asset('assets/images/excel-24.png'),
                  )
                ],
            ),
            Expanded(
              child: ListView(
              children: expenditureList
                  .map((e) => Card(
                        child: Text(e.paymentDate),
                      ))
                  .toList(),
              )
            ),
            // Todo 
            // 총 57건 / 총 금액 
            // 처음으로 버튼 
            // 왼쪽 화살표 페이징 오른쪽 화살표
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // 테두리 스타일
                          borderRadius: BorderRadius.circular(10.0), // 박스 모서리 둥글게
                        ),
                    child: Column(
                      children:[
                        Text('총 00건'),
                        Text('총 12887원 ')
                      ]
                    )
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0), // 버튼 패딩
                    ),
                    onPressed: () {
                      // 아이콘을 클릭했을 때 수행할 동작을 여기에 추가하세요.
                      // 예: 새 항목 추가 또는 다른 기능 수행
                    },
                    child: Text('처음으로'), // 버튼 텍스트
                  ),
                ],
            ),
            //Todo
            // 페이징
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      
                    },
                  )
                  )
              ],
            )

          ],
        ));
  }
  
}

