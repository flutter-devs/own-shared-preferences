import 'package:flutter/cupertino.dart';

class Dimensions {
  static double boxWidth;
  static double boxHeight;

  Dimensions(BuildContext context) {
    boxHeight = MediaQuery.of(context).size.height / 100;
    boxWidth = MediaQuery.of(context).size.width / 100;
  }
}
