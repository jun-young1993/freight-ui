import 'package:flutter/material.dart';

class ButtonExpansionItem {
  final Widget button;
  const ButtonExpansionItem(
      this.button
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
    return Scaffold(
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            return _buildElevatedButton(items[index], index);
          }
      )
    );
  }

  Widget _buildElevatedButton(ButtonExpansionItem item, int index){
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
          if (expandedButtonContent == index) Text("버튼 1의 내용")
        ],
      )
    );

  }
}
