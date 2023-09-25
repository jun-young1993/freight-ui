import 'package:flutter/material.dart';
import 'package:freight_ui/config/images.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Image(
        height: screenHeight * 3,
        image: AppImages.loader
      ),
    );
  }

}