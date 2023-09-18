part of '../user.dart';

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

  void guestLogin() {
    userBloc.add(const GuestLogin());
  }

  void signUp() {
    userBloc.add(const SignUp());
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
          child: Text(title),
        )
    );
  }
}