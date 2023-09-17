import 'package:flutter/material.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/routes.dart';
import 'package:freight_ui/ui/widgets/main_app_bar.dart';
import 'package:freight_ui/ui/widgets/main_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
              NestedScrollView(
              key: _scrollKey,
              headerSliverBuilder: (_, __) => [
                    MainSliverAppBar(
                      leadingIconData: Icons.home,
                      onLeadingPress: (){},
                      title: AppRouteMap.getName(Routes.home),
                      context: context,
                    )
              ],
              body : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildImage(),
                      _buildMenus(AppRouteMap.getShowMenu())
                    ],
                  ),
                )
              )
            )
        ],
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
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextButton(
          onPressed: () => _onSelectMenu(route),
          child: Text(AppRouteMap.getName(route))
      ),
    );
    
  }

  void _onSelectMenu(Routes route){
    AppNavigator.push(route);
  }
}