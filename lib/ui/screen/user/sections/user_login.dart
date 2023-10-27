part of '../user.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freight_ui/config/colors.dart';
// import 'package:freight_ui/config/images.dart';
// import 'package:freight_ui/config/route_map.dart';
// import 'package:freight_ui/routes.dart';
// import 'package:freight_ui/states/user/user_bloc.dart';
// import 'package:freight_ui/states/user/user_event.dart';

class _UserLogin extends StatefulWidget {
  const _UserLogin();

  @override
  State<StatefulWidget> createState() => _UserLoginState();
}

class _UserLoginState extends State<_UserLogin> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  BuildContext get context => super.context;
  UserBloc get userBloc => context.read<UserBloc>();


  @override
  void initState() {
    super.initState();
  }

  void userLogin() {
    userBloc.add(const UserLogin());
  }

  void guestLogin() async  {
    userBloc.add(const GuestLogin());
    await AppNavigator.push(Routes.home);
  }

  void signUp() {
    AppNavigator.push(Routes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        key: _scrollKey,
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context),
            _buildTitle(context),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            _buildButton(context,'GUEST',guestLogin),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            _buildButton(context,'LOG IN',userLogin),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            _buildButton(context,'SIGN UP',signUp),
          ],
        )
    );
  }
  Widget _buildImage(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.03),
      alignment: Alignment.center,
      child: const Image(image: AppImages.truck),
    );
  }

  Widget _buildTitle(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: Title(
          color: AppColors.black,
          child: Text(
              style: TextStyle(fontSize: screenHeight * 0.05),
              AppRouteMap.getName(Routes.simpleLogin)
          )
      ),
    );

  }

  Widget _buildButton(BuildContext context, title, VoidCallback onPressed){
    double screenHeight = MediaQuery.of(context).size.height;
    return MainFreightText(
      text: title,
      onPressed: onPressed,
    );
  }
}