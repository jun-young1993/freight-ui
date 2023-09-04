import 'package:flutter/material.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/main_view.dart';

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
    return MainAppView(
      child: Center(
        child: Text('뒤로가기'),
      )
    );
  }
}