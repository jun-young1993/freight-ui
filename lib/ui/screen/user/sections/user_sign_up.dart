

part of '../user.dart';


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
                      AppNavigator.push(Routes.home);
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
          print('on success sign in');
          userBloc.add(Registration(dto));

        },
        onFailure: (context, state) {
          LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(state.failureResponse!))
              );
        },
        child: UserForm(
          formBloc : userFormBloc
        )
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