import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class ExpenditureScreen extends StatefulWidget {
  const ExpenditureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenditureScreenState();
}

class _ExpenditureScreenState extends State<ExpenditureScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () => {
                AppNavigator.pop()
              },
              child: const Text('뒤로가기'),
            ),
            const Text('지출내역 UI')
          ],
        ),
      )
    );
  }
}