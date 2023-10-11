import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/dto/drive.dart';
import 'package:freight_ui/domain/entities/drive.dart';
import 'package:freight_ui/repositories/drive_repository.dart';
import 'package:freight_ui/utills/date.dart';



class DriveFormBloc extends FormBloc<String, String> {



  

  final loadingDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final loadingPlace = TextFieldBloc(
    validators: [FieldBlocValidators.required]
  );
  final unloadingDate = InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final unloadingPlace = TextFieldBloc(
    validators: [FieldBlocValidators.required]
  );
  
  final loadingRatio = TextFieldBloc<int>(
    initialValue: "0",
      validators: [
        FieldBlocValidators.required,
            (value) {
          if(value.isNotEmpty){
            try{
              if(int.parse(value) > 100){

                return '100 이하의 숫자로 작성해주세요.';
              }
            } catch(e) {
              return '유효한 숫자를 입력하세요.';
            }
          }
          return null;
        }
      ]
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
  final transportationType = TextFieldBloc(
    validators: [FieldBlocValidators.required]
  );
  final unitCost = TextFieldBloc<int>(
    initialValue: "0",
  );
  final extra = TextFieldBloc();



  DriveFormBloc() :
  super(autoValidate: true) {
    addFieldBlocs(fieldBlocs: [
      loadingDate,
      loadingPlace,
      unloadingDate,
      unloadingPlace,
      loadingRatio,
      transportationCosts,
      transportationDate,
      transportationType,
      unitCost,
      extra
    ]);
  }

  void clearValues(){
      loadingDate.clear();
      loadingDate.clear();
      loadingPlace.clear();
      unloadingDate.clear();
      unloadingPlace.clear();
      loadingRatio.clear();
      transportationCosts.clear();
      transportationDate.clear();
      transportationType.clear();
      unitCost.clear();
  }

  void setValues(Drive? drive) {
    if(drive == null){
      clearValues();
    }else{

      loadingDate.changeValue(drive.loadingDate);
      loadingPlace.changeValue(drive.loadingPlace);
      unloadingDate.changeValue(drive.unloadingDate);
      unloadingPlace.changeValue(drive.unloadingPlace);
      loadingRatio.changeValue(drive.loadingRatio.toString());
      transportationCosts.changeValue(drive.transportationCosts.toString());
      transportationDate.changeValue(drive.transportationDate);
      transportationType.changeValue(drive.transportationType);
      unitCost.changeValue(drive.unitCost.toString());
    }
    
    // extra.changeValue(drive.extra);
    
  }

  void addErrors() {
    
    loadingDate.addFieldError('Awesome Error!');
    loadingPlace.addFieldError('Awesome Error!');
    unloadingDate.addFieldError('Awesome Error!');
    unloadingPlace.addFieldError('Awesome Error!');
    loadingRatio.addFieldError('Awesome Error!');
    transportationCosts.addFieldError('Awesome Error!');
    transportationDate.addFieldError('Awesome Error!');
    transportationType.addFieldError('Awesome Error!');
    unitCost.addFieldError('Awesome Error!');
    extra.addFieldError('Awesome Error!');
  }


  @override
  void onSubmitting() async {
    try {

      // await Future<void>.delayed(const Duration(milliseconds: 500));

      // Drive drive = await _driveRepository.create(

      // );

      emitSuccess(
          successResponse: DriveDto(
              loadingDate: loadingDate.value as DateTime,
              loadingPlace: loadingPlace.value,
              unloadingDate: unloadingDate.value as DateTime,
              unloadingPlace: unloadingPlace.value,
              loadingRatio: loadingRatio.valueToInt as int,
              transportationCosts: transportationCosts.valueToInt as int,
              transportationDate: transportationDate.value as DateTime,
              transportationType: transportationType.value,
              unitCost: unitCost.valueToInt as int,
              extra: extra.value
          ).toJson(),
          canSubmitAgain: true
      );
    } catch (e) {

      emitFailure(failureResponse: e.toString());
    }
  }
}



