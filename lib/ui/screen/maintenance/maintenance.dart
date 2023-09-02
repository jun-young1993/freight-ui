import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
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
            const Text('Maintenance UI')
          ],
        ),
      )
    );
  }
}