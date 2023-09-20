import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freight_ui/config/colors.dart';

class UserInputField extends StatelessWidget {
  final String label;
  final double labelSize;
  const UserInputField({
      required String this.label,
    double this.labelSize = 0.05
  });




  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth * 0.15,
          child: Text(
              style: TextStyle(
                  fontSize: screenHeight * labelSize, color: AppColors.black
              ),
              label
          ),
        ),
        SizedBox(
          width: screenWidth * 0.1,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder()
            ),
          ),
        ),
      ],
    );
  }
  
}