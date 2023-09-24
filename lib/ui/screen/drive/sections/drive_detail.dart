import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';
import 'package:freight_ui/utills/date.dart';

class DriveDetail extends StatelessWidget {
  final Drive drive;

  DriveDetail({super.key, required this.drive});


  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ContainerTitle(title: '상세조회'),
              Container(
                padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenHeight * 0.02),
                child: Text("TODAY ${CurrentDate("yyyy-MM-dd", dateTime: drive.createdAt)}"),
              )

            ],
          ),
        ),
      );
  }

}