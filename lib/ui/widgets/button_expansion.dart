import 'package:flutter/material.dart';

class ButtonExpansionItem {
  final Widget button;
  final Widget context;
  const ButtonExpansionItem(
      this.button, this.context
  );
}


class ButtonExpansion extends StatefulWidget {
  final List<ButtonExpansionItem> items;
  const ButtonExpansion({
    super.key,
    required this.items
  });

  @override
  _ButtonExpansionState createState() => _ButtonExpansionState();
}

class _ButtonExpansionState extends State<ButtonExpansion> {
  int? expandedButtonContent = null;
  List<ButtonExpansionItem> get items => super.widget.items;


  void expandButton(int content) {
    setState(() {
      if(expandedButtonContent == content){
        expandedButtonContent = null;
      }else{
        expandedButtonContent = content;
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                _buildElevatedButton(items[index], index),
                SizedBox(height: screenHeight * 0.01,)
              ],
            );
              
          }
      )
    );
  }

  Widget _buildElevatedButton(ButtonExpansionItem item, int index){
    
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: Colors.transparent,
              backgroundColor: Colors.transparent, // 배경색을 하얀색으로 설정
            ),
            onPressed: () => expandButton(index),
            child: item.button,
          ),
          if (expandedButtonContent == index) Column(
            children: [
              SizedBox(height: screenHeight * 0.005,),
              item.context,
              SizedBox(height: screenHeight * 0.005,),
            ],
            )
        ],
      )
    );

  }
}
