import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freight_ui/app.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/repositories/user_repository.dart';
import 'package:freight_ui/services/excel_service.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/states/user/user_bloc.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<DriveRepository>(
        create: (context) => DriveDefaultRepository()
      ),
      RepositoryProvider<UserRepository>(
          create: (context) => UserDefaultRepository()
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DriveBloc(
                context.read<DriveRepository>()
            )
        ),
        BlocProvider(
            create: (context) => UserBloc(
              context.read<UserRepository>()
            )
        )
      ],
      child: const FreightApp(),
    ),
  ));
  // runApp(const FreightApp());
}
