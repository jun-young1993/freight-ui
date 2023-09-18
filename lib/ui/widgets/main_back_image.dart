import 'package:flutter/cupertino.dart';
import 'package:freight_ui/config/images.dart';
import 'package:freight_ui/routes.dart';



class MainBackImage extends StatelessWidget {
  const MainBackImage();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * 0.15,
        padding: EdgeInsets.all(screenHeight * 0.03),
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () => AppNavigator.pop(),
          child: const Image(image: AppImages.truck),
        )

    );
  }
}