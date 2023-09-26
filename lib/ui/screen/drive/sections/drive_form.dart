// part of '../drive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/utills/date.dart';

class DriveForm extends StatefulWidget {
  final Drive? drive;
  const DriveForm({
    super.key,
    this.drive
  });

  @override
  _DriveFormState createState() => _DriveFormState();
}

class _DriveFormState extends State<DriveForm> {
  final _formKey = GlobalKey<_DriveFormState>();
  Drive? get drive => widget.drive;
  // String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // final TextEditingController _loadDateInput = TextEditingController();
  // final TextEditingController _unLoadDateInput = TextEditingController();
  final Map<String,TextEditingController> _formController = {
    "loadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "loadingPlace": TextEditingController(),
    "unLoadingDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "unLoadingPlace": TextEditingController(),
    "loadingRatio": TextEditingController(),
    "transportationCosts": TextEditingController(),
    "transportationDate": TextEditingController(text: CurrentDate('yyyy-MM-dd')),
    "transportationType": TextEditingController(),
    "unitCost": TextEditingController(),
    "extra": TextEditingController(), 
  };
  
  DriveBloc get driveBloc => context.read<DriveBloc>();

  // loadDateInput.text = currentDate;
  // unLoadDateInput.text = currentDate;
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _formController.forEach((_, value) { 
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
        ]
      ),
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