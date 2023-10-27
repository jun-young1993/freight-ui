import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freight_ui/config/colors.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/config/texts.dart';
import 'package:freight_ui/domain/entities/user.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/states/user/user_bloc.dart';
import 'package:freight_ui/states/user/user_event.dart';
import 'package:freight_ui/states/user/user_selector.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';
import 'package:freight_ui/ui/widgets/main_view.dart';
import 'package:freight_ui/utills/date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  UserBloc get userBloc => context.read<UserBloc>();
  
  @override
  void initState() {
    super.initState();

    userBloc.add(const UserStateEvent());
  }

  @override
  Widget build(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildUserTitle(),
                _buildTitle(),
                _buildMenus(AppRouteMap.getShowMenu()),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                _buildYear()
              ],
            ),
          )
       
        ],
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
                  AppNavigator.push(Routes.settings);
                },
              )            
          ],  
          ),
        ) ;
      }
    );
  }

  Widget _buildTitle(){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(bottom: screenHeight * 0.1),
      // color: AppColors.white,
      alignment: Alignment.center,
      child: Title(
        color: AppColors.black,
        child: Text(
          style: TextStyle(fontSize: screenHeight * 0.05, color: AppColors.black),
          AppText.freightRequest
        )
      )
    );
  }
  
  Widget _buildMenus(List<Routes> routes){
    return Container(
      child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(1),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children:routes.map((Routes route) => _buildMenu(route)).toList(),
      ) 
    );
  }

  Widget _buildMenu(Routes route){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: AppColors.black
      ),
      child: TextButton(
          onPressed: () => _onSelectMenu(route),
          child: Text(
            style: TextStyle(
              color: AppColors.white,
              fontSize: screenHeight * 0.03
            ),
            AppRouteMap.getName(route)
          )
      ),
    );
    
  }

  Widget _buildYear(){
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all()
      ),
      child: TextButton(
          onPressed: () {},
          child: Text(
            style: TextStyle(
              color: AppColors.black,
              fontSize: screenHeight * 0.08
            ),
            CurrentDate('yyyy')
          )
      ),
    );
  }

  void _onSelectMenu(Routes route){
    AppNavigator.push(route);
  }
}