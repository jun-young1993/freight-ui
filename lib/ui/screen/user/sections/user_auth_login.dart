part of '../user.dart';
class UserAuthLogin extends StatefulWidget {
  const UserAuthLogin();

  @override
  State<StatefulWidget> createState() => _UserAuthLoginState();
}

class _UserAuthLoginState extends State<UserAuthLogin> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  BuildContext get context => super.context;
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
                _buildImage(),
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

  Widget _buildImage(){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      padding: EdgeInsets.all(screenHeight * 0.03),
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => AppNavigator.pop(),
        child: const Image(image: AppImages.truck),
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
          _buildLoginInputField('ID'),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          _buildLoginInputField('PW'),

        ],
      )
    );

  }

  Widget _buildLoginInputField(String label){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth * 0.15,
          child: Text(
              style: TextStyle(
                  fontSize: screenHeight * 0.05, color: AppColors.black
              ),
              label
          ),
        ),
        SizedBox(
          width: screenWidth * 0.1,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder()
            ),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.05,
        ),

      ],
    );
  }
  
}
