part of '../setting.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu();
  @override
  State<StatefulWidget> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
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
        padding: EdgeInsets.only(left: screenHeight * 0.05, bottom: screenHeight * 0.1),
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

  Widget _buildAnimationMenu(){
    return  ButtonExpansion(
      items: <ButtonExpansionItem>[
        ButtonExpansionItem(
          MainFreightText(text: '사용자 정보 및 수정',fontSize: 0.045,),
        ),
        ButtonExpansionItem(MainFreightText(text: '기존 계정 연동',fontSize: 0.045,),),
        ButtonExpansionItem(MainFreightText(text: '기기 변경',fontSize: 0.045,),)
      ],
    );
  }
}
