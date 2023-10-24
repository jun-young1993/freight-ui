import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';

class MainFreightText extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double fontSize;

  MainFreightText({
    super.key,
    required this.text, this.onPressed,
    this.fontSize = 0.05,
  });



  @override
  Widget build(BuildContext context){
      double screenHeight = MediaQuery.of(context).size.height;
      return Container(
          margin: EdgeInsets.only(left: screenHeight * 0.02, right: screenHeight * 0.02),
          padding: EdgeInsets.all(screenHeight * 0.008),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.black),
              color: AppColors.white
          ),
          child: (
              onPressed == null ? Text(text, style: TextStyle(
                color: Colors.black,
                fontSize: screenHeight * fontSize
              ),)
              : TextButton(
                onPressed: onPressed ?? () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: screenHeight * 0.05),
                ),
                child: Text(text),
          )
          )
      );
    }
}

