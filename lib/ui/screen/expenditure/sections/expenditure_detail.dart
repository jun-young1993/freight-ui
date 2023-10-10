import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpenditureDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(' 지출 내역 상세 정보'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(' 여기에 세부 정보 있어야 함.'),
        )
      )

    );
  }


}