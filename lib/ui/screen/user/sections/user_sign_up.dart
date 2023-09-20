part of '../user.dart';



class UserSignUp extends StatefulWidget {
  const UserSignUp();

  @override
  State<StatefulWidget> createState() => _UserSignUpState();

}

class _UserSignUpState extends State<UserSignUp> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();
  UserBloc get userBloc => context.read<UserBloc>();
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
                    () {

                    }
                ),
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
            onTap: onPressed,
            child: Text(
                style: TextStyle(
                    fontSize: screenHeight * 0.05,
                    color: AppColors.black
                ),
                label
            ),
          ),
        )
    );
  }

  Widget _buildSignForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInputField(label: 'ID', labelSize: 0.02,),
          UserInputField(label: 'CONTACT', labelSize: 0.02),
          UserInputField(label: 'E-MAIL', labelSize: 0.02),
          UserInputField(label: 'NAME', labelSize: 0.02),
        ],
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