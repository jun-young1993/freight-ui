import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  final text1 = TextFieldBloc();

  final boolean1 = BooleanFieldBloc();

  final boolean2 = BooleanFieldBloc();

  final select1 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
    validators: [FieldBlocValidators.required],
  );

  final select2 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
    validators: [FieldBlocValidators.required],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
    ],
  );
  final file = InputFieldBloc<File?, String>(initialValue: null);

  final date1 = InputFieldBloc<DateTime?, Object>(initialValue: null);

  final dateAndTime1 = InputFieldBloc<DateTime?, Object>(initialValue: null);

  final time1 = InputFieldBloc<TimeOfDay?, Object>(initialValue: null);

  final double1 = InputFieldBloc<double, dynamic>(
    initialValue: 0.5,
  );

  

  AllFieldsFormBloc() : super(autoValidate: false) {
    addFieldBlocs(fieldBlocs: [
      text1,
      boolean1,
      boolean2,
      select1,
      select2,
      multiSelect1,
      date1,
      dateAndTime1,
      time1,
      double1,
    ]);
  }

  void addErrors() {
    text1.addFieldError('Awesome Error!');
    boolean1.addFieldError('Awesome Error!');
    boolean2.addFieldError('Awesome Error!');
    select1.addFieldError('Awesome Error!');
    select2.addFieldError('Awesome Error!');
    multiSelect1.addFieldError('Awesome Error!');
    date1.addFieldError('Awesome Error!');
    dateAndTime1.addFieldError('Awesome Error!');
    time1.addFieldError('Awesome Error!');
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}