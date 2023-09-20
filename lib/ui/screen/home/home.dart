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
    return Scaffold(
      body: Stack(
        children: [
          Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserEntityStateSelector(
                        builder: (User user) {
                          print('user entity state selector');
                          return Container(
                            alignment: Alignment.topLeft,
                            child: Text(user.name),
                          );
                        }
                      ),
                      // _buildImage(),
                      _buildTitle(),
                      _buildMenus(AppRouteMap.getShowMenu())
                    ],
                  ),
                )
              )
        ],
        // children: [
        //       NestedScrollView(
        //       key: _scrollKey,
        //       headerSliverBuilder: (_, __) => [
        //             MainSliverAppBar(
        //               leadingIconData: Icons.home,
        //               onLeadingPress: (){},
        //               title: AppRouteMap.getName(Routes.home),
        //               context: context,
        //             )
        //       ],
        //       body : Center(
        //         child: SingleChildScrollView(
        //           child: Column(
        //             children: [
        //               // _buildImage(),
        //               _buildMenus(AppRouteMap.getShowMenu())
        //             ],
        //           ),
        //         )
        //       )
        //     )
        // ],
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
          AppText.freightRequest
        )
      )
    );
  }

  Widget _buildImage(){
    return Container(
      child: const Image(image: AppImages.truck),
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
      padding: const EdgeInsets.all(8),
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

  void _onSelectMenu(Routes route){
    AppNavigator.push(route);
  }
}