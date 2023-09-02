import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class DriveScreen extends StatefulWidget {
  const DriveScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DriveScreenState();
}

class _DriveScreenState extends State<DriveScreen> {
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
            const Text('운행일지 UI')
          ],
        ),
      )
    );
  }
}