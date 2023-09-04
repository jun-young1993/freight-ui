import 'package:flutter/material.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';
import 'package:freight_ui/ui/widgets/main_view.dart';

part 'sections/drive_grid.dart';
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
      body: Stack(
        fit: StackFit.expand, 
        children: [
          _DriveGrid()
        ],
      )
    );

  }
}