import 'package:flutter/material.dart';
import 'package:freight_ui/config/constant.dart';
import 'package:freight_ui/routes.dart';

class MainAppView extends StatelessWidget {
  final Widget child;
  final bool goBack;

  const MainAppView({
    super.key, 
    required this.child, 
    this.goBack = true
  });
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: _buildGoBack(),
        title: _buildTitle()
      ),
      body : child
    );
  }

  Widget? _buildGoBack(){
    if(goBack){
      return IconButton(
          icon: Icon(Icons.arrow_left_sharp), 
          onPressed: () { 
            AppNavigator.pop();
          },
        );
    }
  }

  Widget _buildTitle(){
    return Text(AppConstant.name);
  }

  
}