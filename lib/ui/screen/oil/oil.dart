import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class OilScreen extends StatefulWidget {
  const OilScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OilScreenState();
}

class _OilScreenState extends State<OilScreen> {
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
            const Text('Oil UI')
          ],
        ),
      )
    );
  }
}