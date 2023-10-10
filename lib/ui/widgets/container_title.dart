import 'package:flutter/cupertino.dart';
import 'package:freight_ui/config/colors.dart';

class ContainerTitle extends StatelessWidget {
  final String title;

  const ContainerTitle({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.03, left: screenHeight * 0.02),
      child: Text(
          style: TextStyle(
              color: AppColors.orange,
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.bold
          ),
          title
      ),
    ) ;

  }

}