import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/app.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<DriveRepository>(
        create: (context) => DriveDefaultRepository()
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DriveBloc(context.read<DriveRepository>()))
      ],
      child: const FreightApp(),
    ),
  ));
  // runApp(const FreightApp());
}
