import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {

  // test용 지출 내역
  final List<String> expenditureList = [
    "식비: \$50",
    "교통비: \$30",
    "쇼핑: \$100",
    "기타: \$20",
  ];

  @override
  void initState() {
    super.initState();
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
                  // 햄버거 버튼을 눌렀을 때 실행되는 동작을 정의할 수 있습니다.
                  // 여기에 네비게이션 드로어를 열거나 원하는 동작을 추가할 수 있습니다.
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: expenditureList.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(expenditureList[index]),
                    // 각 항목 선택 - 상세 페이지
                    onTap: () {
                      // 상세 페이지 이동.

                    },
                  );
                }
              ),
            )

          ],
        ),
      )
    );

  }
}