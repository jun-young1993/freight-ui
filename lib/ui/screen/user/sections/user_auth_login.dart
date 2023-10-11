part of '../user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// import 'package:freight_ui/config/colors.dart';
// import 'package:freight_ui/states/user/user_bloc.dart';
// import 'package:freight_ui/ui/widgets/main_back_image.dart';
// import 'package:freight_ui/ui/widgets/user_input_field.dart';

class UserAuthLogin extends StatefulWidget {
  const UserAuthLogin();

  @override
  State<StatefulWidget> createState() => _UserAuthLoginState();
}

class _UserAuthLoginState extends State<UserAuthLogin> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();


  UserBloc get userBloc => context.read<UserBloc>();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
            SingleChildScrollView(
            key: _scrollKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MainBackImage(),
                _buildTitle(),
                _buildForm(),
                _buildLogin()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLogin(){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.1 ,
          right: screenWidth * 0.1,
          top: screenHeight * 0.1
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all()
        ),
       child: GestureDetector(
         child: Text(
             style: TextStyle(
                 fontSize: screenHeight * 0.05,
                 color: AppColors.black
             ),
             'OK!'
         ),
       ),
      )
    );
  }

  Widget _buildTitle(){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.white,
      alignment: Alignment.center,
      child: Title(
        color: AppColors.black,
        child: Text(
          style: TextStyle(fontSize: screenHeight * 0.05, color: AppColors.black),
          "환영합니다"
        )
      )
    );
  }

  Widget _buildForm(){
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          UserInputField(label: 'ID'),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          UserInputField(label: 'PW',)

        ],
      )
    );

  }


  
}
