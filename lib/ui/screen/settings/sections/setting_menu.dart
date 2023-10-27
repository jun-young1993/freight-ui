part of '../setting.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu();
  @override
  State<StatefulWidget> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  UserFormBloc get userFormBloc => context.read<UserFormBloc>();
  UserBloc get userBloc => context.read<UserBloc>();
          
    @override
  void initState() {
    super.initState();

    userBloc.add(const UserStateEvent());
  }
  @override
  Widget build(BuildContext context) {
    return
      // SingleChildScrollView(
      // child:
    Column(
        children: [
          _buildUserTitle(),
          _buildTitle(),
          Expanded(child: _buildAnimationMenu())

        ],
      );
    // );
  }
  Widget _buildTitle(){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(left: screenHeight * 0.05, bottom: screenHeight * 0.05),
        // color: AppColors.white,
        alignment: Alignment.topLeft,
        child: Title(
            color: AppColors.black,
            child: Text(
                style: TextStyle(fontSize: screenHeight * 0.05, color: AppColors.black),
                AppText.settings
            )
        )
    );
  }
  Widget _buildUserTitle(){
    double screenHeight = MediaQuery.of(context).size.height;
    
    return UserEntityStateSelector(
        builder: (User user) {

          return Container(
            padding: EdgeInsets.all(screenHeight * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    style: TextStyle(fontSize: screenHeight * 0.03, color: AppColors.black),
                    user.name
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    AppNavigator.pop();
                  },
              )],
            ),
          ) ;
        }
    );
  }

  Widget _buildUserForm(){
    
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
          // userBloc.add(Registration(dto));

        },
        onFailure: (context, state) {
          LoadingDialog.hide(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.red,
                content: Text(state.failureResponse!))
              );
        },
        child: UserEntityStateSelector(
            builder: (User user) {
              
                userFormBloc.setValues(user);
              
              
              return UserForm(
                formBloc : userFormBloc,
              );
            }
        )

    );
  }

  Widget _buildAnimationMenu(){
    
    return  ButtonExpansion(
      items: <ButtonExpansionItem>[
        ButtonExpansionItem( 
          MainFreightText(text: '사용자 정보 및 수정',fontSize: 0.045,),
          _buildUserForm()
        ),
        ButtonExpansionItem(
          MainFreightText(text: '기존 계정 연동',fontSize: 0.045,),
          Text('h2')
        ),
        ButtonExpansionItem(
          MainFreightText(text: '기기 변경',fontSize: 0.045),
          userAuthTokenSelector(
            builder: (token) {
              print('user auth token selector ${token}');
              return Column(
                children: [
                  Text('token: ${token}')
                ],
              );
            },
          )
        ),
      ],
    );
  }


}
