import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/domain/excel.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/states/drive/drive_event.dart';
import 'package:freight_ui/states/drive/drive_form_bloc.dart';
import 'package:freight_ui/states/drive/drive_selector.dart';
import 'package:freight_ui/states/drive/drive_state.dart';
import 'package:freight_ui/ui/screen/drive/sections/drive_card.dart';
import 'package:freight_ui/ui/screen/drive/sections/drive_detail.dart';
import 'package:freight_ui/ui/widgets/container_title.dart';
import 'package:freight_ui/ui/widgets/loader.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:freight_ui/utills/date.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
part 'sections/drive_grid.dart';
part 'sections/drive_form.dart';


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
    return const Scaffold(
      body: Stack(
          fit: StackFit.expand, 
          children: [
            _DriveGrid(),
            // _DriveFabMenu(),
          ],
        ),
    );

  }
}
