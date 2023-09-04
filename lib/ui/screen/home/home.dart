import 'package:flutter/material.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/config/route_map.dart';
import 'package:freight_ui/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: _buildTitle()
        ),
        body : Center(
          child:  Column(
            children: [
              _buildImage(),
              _buildMenus([
                  Routes.drive,
                  Routes.expenditure,
                  Routes.oil,
                  Routes.maintenance
              ])
          ],)
        )
    );
  }

  Widget _buildTitle(){
    return Text(AppConstant.name);
  }

  Widget _buildImage(){
    return Container(
      child: Image(image: AppImages.main),
    );
  }

  Widget _buildMenus(List<Routes> routes){
    return Container(
      child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children:routes.map((Routes route) => _buildMenu(route)).toList(),
      ) 
    );
  }

  Widget _buildMenu(Routes route){
    return Container(
      // padding: const EdgeInsets.all(8),
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