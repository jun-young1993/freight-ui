import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/utills/date.dart';

class DriveFormBloc extends FormBloc<String, String> {
  final loadingDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final loadingPlace = TextFieldBloc();
  final unLoadingDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final unLoadingPlace = TextFieldBloc(
    
  );
  
  final loadingRatio = TextFieldBloc<int>(
    initialValue: "0",
  );
  final transportationCosts = TextFieldBloc<int>(
    initialValue: "0",
  );
  final transportationDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  //  ?? 뭔지 모르겠음
  // final transportationType = SelectFieldBloc(
  //   items: ['8톤', '11톤'],
  //   validators: [FieldBlocValidators.required],
  // );
  final transportationType = TextFieldBloc();
  final unitCost = TextFieldBloc<int>(
    initialValue: "0",
  );
  final extra = TextFieldBloc();

  DriveFormBloc() : super(autoValidate: true) {
    addFieldBlocs(fieldBlocs: [
      loadingDate,
      loadingPlace,
      unLoadingDate,
      unLoadingPlace,
      loadingRatio,
      transportationCosts,
      transportationDate,
      transportationType,
      unitCost,
      extra
    ]);
  }

  void addErrors() {
    loadingDate.addFieldError('Awesome Error!');
  }

  @override
  void onSubmitting() async {
    try {
      print(loadingDate.value);
      // await Future<void>.delayed(const Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}