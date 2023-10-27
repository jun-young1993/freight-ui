import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:freight_ui/domain/entities/user.dart';
import 'package:freight_ui/states/user/user_form_bloc.dart';

class UserForm extends StatelessWidget {
  final UserFormBloc formBloc;
  const UserForm({
    super.key, 
    required this.formBloc, 
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableFormBlocManager(
          formBloc: formBloc, 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child:         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldBlocBuilder(
                  textFieldBloc: formBloc.userId,
                  decoration: const InputDecoration(
                      labelText: 'ID'
                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: formBloc.contact,
                  decoration: InputDecoration(
                      labelText: 'CONTACT'
                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: formBloc.email,
                  decoration: InputDecoration(
                      labelText: 'E-MAIL'
                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: formBloc.name,
                  decoration: InputDecoration(
                      labelText: 'NAME'
                  )
              ),
            ],
          )
        ),
      );
  }

}