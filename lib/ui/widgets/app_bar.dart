import 'package:flutter/material.dart';
import 'package:freight_ui/config/constant.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key, 
    required this.child
  });
  
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle()
      ),
      body : child
    );
  }

    Widget _buildTitle(){
      return Text(AppConstant.name);
    }

  
}