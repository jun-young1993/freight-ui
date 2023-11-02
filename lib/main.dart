import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freight_ui/app.dart';
import 'package:freight_ui/repositories/common_repository.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/repositories/user_repository.dart';
import 'package:freight_ui/states/drive/drive_bloc.dart';
import 'package:freight_ui/states/drive/drive_form_bloc.dart';
import 'package:freight_ui/states/user/user_bloc.dart';
import 'package:freight_ui/states/user/user_form_bloc.dart';


void main() async {
  await dotenv.load(fileName: '.env');
  onError();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<DriveRepository>(
        create: (context) => DriveDefaultRepository()
      ),
      RepositoryProvider<UserRepository>(
          create: (context) => UserDefaultRepository()
      ),
      RepositoryProvider<CommonRepository>(
          create: (context) => CommonDefaultRepository()
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DriveBloc(
                context.read<DriveRepository>(),
                context.read<CommonRepository>()
            )
        ),
        BlocProvider(
            create: (context) => UserBloc(
              context.read<UserRepository>()
            )
        ),
        BlocProvider<DriveFormBloc>(
          create: (context) => DriveFormBloc(),
        ),
        BlocProvider<UserFormBloc>(
          create: (context) => UserFormBloc()
        )
      ],
      child: const FreightApp(),
    ),
  ));
  // runApp(const FreightApp());
}


void onError() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // 글로벌 예외

    print('error detail:');
    print(details.exceptionAsString());

  };
}