import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/dto/user.dart';

class UserFormBloc extends FormBloc<String, String> {
  // {
  // "contact": "010-4157-8829",
  // "email": "asdf@gmail.com",
  // "extra": "기타 특이 사항 : 피부가 많이 까맣다.",
  // "name": "김준영의 발톱을 먹고 태어난 시골쥐",
  // "userId": "2001user001"
  // }
  final userId = TextFieldBloc(
      validators: [FieldBlocValidators.required]
  );
  final contact = TextFieldBloc(
      validators: [FieldBlocValidators.required]
  );
  final name = TextFieldBloc(
      validators: [FieldBlocValidators.required]
  );
  final email = TextFieldBloc(
      validators: [FieldBlocValidators.required]
  );


  UserFormBloc():
  super(autoValidate: true) {
    addFieldBlocs(
        fieldBlocs: [
          userId,
          contact,
          name,
          email,
        ]
    );
  }

  @override
  void onSubmitting() async {
    try{
      emitSuccess(
        successResponse: UserDto(
            id: userId.value,
            contact: contact.value,
            email: email.value,
            name: name.value,
        ).toJson(),
        canSubmitAgain: true
      );
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}