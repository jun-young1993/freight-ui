

part of '../user.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// import 'package:freight_ui/config/colors.dart';
// import 'package:freight_ui/states/user/user_bloc.dart';
// import 'package:freight_ui/states/user/user_event.dart';
// import 'package:freight_ui/states/user/user_form_bloc.dart';
// import 'package:freight_ui/ui/widgets/main_back_image.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp();

  @override
  State<StatefulWidget> createState() => _UserSignUpState();

}

class _UserSignUpState extends State<UserSignUp> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();
  UserBloc get userBloc => context.read<UserBloc>();
  UserFormBloc get userFormBloc => context.read<UserFormBloc>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            key: _scrollKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMainBackImage(),
                _buildSignForm(),
                _buildButton(
                    'OK',
                    () => userFormBloc.submit()
                ),
                SizedBox(height: 20,),
                _buildButton(
                    'GUEST',
                    () {
                      userBloc.add(const GuestLogin());
                    }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton(
      String label,
      VoidCallback onPressed
  ){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
        margin: EdgeInsets.only(left: screenHeight * 0.02, right: screenHeight * 0.02),
        padding: EdgeInsets.all(screenHeight * 0.008),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            color: AppColors.white
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: TextStyle(fontSize: screenHeight * 0.05),
          ),
          child: Text(label),
        )
    );
     
  }

  Widget _buildSignForm() {
    return FormBlocListener<UserFormBloc, String, String>(
       onSubmitting: (context, state) {
          if(state.isValid()){
            LoadingDialog.show(context);
          }
        },
        onSuccess: (context, state){
          LoadingDialog.hide(context);
          final Map<String, dynamic> jsonData = json.decode(state.successResponse as String);
          final UserDto dto = UserDto.fromJson(jsonData);
          userBloc.add(SignUp(dto));

        },
        onFailure: (context, state) {
          LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(state.failureResponse!))
              );
        },
        child: ScrollableFormBlocManager(
          formBloc: userFormBloc, 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child:         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldBlocBuilder(
                  textFieldBloc: userFormBloc.userId,
                  decoration: const InputDecoration(
                      labelText: 'ID'

                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: userFormBloc.contact,
                  decoration: InputDecoration(
                      labelText: 'CONTACT'
                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: userFormBloc.email,
                  decoration: InputDecoration(
                      labelText: 'E-MAIL'
                  )
              ),
              TextFieldBlocBuilder(
                  textFieldBloc: userFormBloc.name,
                  decoration: InputDecoration(
                      labelText: 'NAME'
                  )
              ),
            ],
          )
        ),
      ),
    );
    
  }

  Widget _buildMainBackImage() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MainBackImage(),
        Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.2),
            child: Container(
              child: Text(
                  style: TextStyle(fontSize: screenHeight * 0.05, color: AppColors.black),
                  '회원 가입'
              ),
            ),
        ),
      ],
    );
  }

}