import 'package:flutter/material.dart';
import 'package:freight_ui/domain/dto/expenditure.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/services/expenditure_service.dart';

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

  @override
  void initState() {
    super.initState();
    loadExpenditureList();
  }

  Future<void> loadExpenditureList() async {
    try {
      final expenditureService = ExpenditureService();
      final result = await expenditureService.getExpenditureList(1, 10, '2023-09-01');
      setState(() {
        expenditureList = result;
      });
      print(' result : $result.data ');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('지출 내역'),
          // 햄버거 버튼 추가 
          leading: Builder( 
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu), // 햄버거 아이콘
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
      body: Center(
        child: Column(
          children: expenditureList
            .map((e) => Card(
              child: Text(e.paymentDate),
            ))
            .toList(),
        ),
      )
    );

  }
}