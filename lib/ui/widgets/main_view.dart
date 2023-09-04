import 'package:flutter/material.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/routes.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({
    super.key, 
    required this.child
  });
  
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_left_sharp), onPressed: () { 
          AppNavigator.pop();
         },),
        title: _buildTitle()
      ),
      body : child
    );
  }

    Widget _buildTitle(){
      return Text(AppConstant.name);
    }

  
}