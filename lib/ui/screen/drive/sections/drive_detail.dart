import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';
import 'package:freight_ui/utills/date.dart';

class DriveDetail extends StatefulWidget {
  final Drive? drive;

  const DriveDetail({super.key, this.drive});

  @override
  State<StatefulWidget> createState() => _DriveDetailState();
  

}

class _DriveDetailState extends State<DriveDetail> {
  // final Drive drive;

  // _DriveDetail({super.key, required this.drive});
  Drive? get drive => widget.drive;

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
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Text("TODAY: ${CurrentDate("yyyy-MM-dd", dateTime: drive!.createdAt)}"),
              ),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("상차 날짜: ${CurrentDate("yyyy-MM-dd", dateTime: drive!.loadingDate)}"),
                    Text("하차 날짜: ${CurrentDate("yyyy-MM-dd", dateTime: drive!.unLoadingDate)}"),
                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("*상차지: ${drive!.loadingPlace}"),
                    Text("*하차 날짜: ${drive!.unLoadingPlace}"),
                  ]
                ),
              ),
              _buildBorderText('운송 품목:', drive!.transportationType),
              _buildBorderText('품목 단가:', drive!.transportationCosts.toString()),
              _buildBorderText('운반비:', drive!.unitCost.toString()),
              Center(
                child: Row(
                  children: [
                    _buildActionButton('수정', () { }),
                    _buildActionButton('삭제', () { }),
                  ]
                ),
              ),
              _buildActionButton('목록으로', () => AppNavigator.pop()),
            ],
          ),
        ),
      );
  }

  Widget _buildActionButton( String title, VoidCallback onPressd) {
    return TextButton(
      onPressed: onPressd, 
      child: Text(title)
    );
  }

  Widget _buildBorderText( String title, String text ) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Container(
        padding: EdgeInsets.all(screenHeight * 0.05),
        // height: screenHeight * 0.05,
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(text)
          ],
        ),
      ),
    );
  }
}