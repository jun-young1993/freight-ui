import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}



class AppImages {
  static const main = _Image('main.png');
  static const truck = _Image('truck.png');
  static const excel = _Image('excel.png');
  static const loader = _Image('loader.gif');
}
